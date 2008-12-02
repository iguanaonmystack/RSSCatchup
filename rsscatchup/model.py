import pkg_resources
pkg_resources.require("SQLAlchemy>=0.3.10")
from turbogears.database import metadata, mapper
# import some basic SQLAlchemy classes for declaring the data model
# (see http://www.sqlalchemy.org/docs/04/ormtutorial.html)
from sqlalchemy import Table, Column, ForeignKey
from sqlalchemy.orm import relation
# import some datatypes for table columns from SQLAlchemy
# (see http://www.sqlalchemy.org/docs/04/types.html for more)
from sqlalchemy import String, UnicodeText, Integer, DateTime

import datetime

# your data tables

# your_table = Table('yourtable', metadata,
#     Column('my_id', Integer, primary_key=True)
# )
comics_table = Table('comic', metadata,
    Column('comic_id', Integer, primary_key=True),
    Column('comic_name', UnicodeText),
    Column('created', DateTime, default=datetime.datetime.now),
    Column('base_url', String(4092)),
    Column('first_comic', Integer),
    Column('start_on', DateTime, default=datetime.datetime.now),
)


# your model classes


# class YourDataClass(object):
#     pass
class Comic(object):
    pass


# set up mappers between your data tables and classes

# mapper(YourDataClass, your_table)
mapper(Comic, comics_table)

