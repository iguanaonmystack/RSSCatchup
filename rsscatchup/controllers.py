import datetime

import turbogears as tg
from turbogears import controllers, expose, flash
from rsscatchup import model

import cherrypy

import logging
log = logging.getLogger("rsscatchup.controllers")

class Root(controllers.RootController):
    @expose(template="rsscatchup.templates.welcome")
    def index(self):
        import time
        # log.debug("Happy TurboGears Controller Responding For Duty")
        flash("Your application is now running")
        return dict(now=time.ctime(), comics=model.Comic.query.all())


    @expose(template='kid:rsscatchup.templates.rss', content_type='application/rss+xml', format='xml')
    def rss(self, comic):
        today = datetime.date.today()
        comic = model.Comic.query.filter_by(comic_name=comic).first()
        if not comic:
            raise cherrypy.HTTPError(404)
        
        days = (today - comic.start_on.date()).days
        cpd = 3 # comics per day
        last_number = comic.first_comic + days * cpd + cpd - 1
        first_number = min(comic.first_comic, last_number - (cpd*7))

        items = []
        for comic_number in range(first_number, last_number+1):
            url = comic.base_url
            if '%s' in comic.base_url:
                url = comic.base_url % (comic_number,)
            else:
                url = comic.base_url + str(comic_number)
            items.append(dict(
                title = "%s #%s" % (comic.comic_name, comic_number),
                link = url,
                guid = "%s #%s" % (comic.comic_name, comic_number),
                description = "%s #%s: %s" % (comic.comic_name, comic_number, url),
            ))

        return dict(
            title = comic.comic_name,
            docs='http://blogs.law.harvard.edu/tech/rss',
            items = items,
        )
