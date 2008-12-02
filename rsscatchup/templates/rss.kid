<?xml version="1.0" encoding='utf-8' ?>
<?xml-stylesheet type="text/css" href="http://nivan.net/static/css/rss.css"?>
<rss version="2.0" xmlns:py="http://purl.org/kid/ns#">
<channel>
    <title py:if="value_of('title')" py:content="title" />
    <link py:if="value_of('link')" py:content="link" />
    <description py:if="value_of('description')" py:content="description" />
    <language py:if="value_of('language')" py:content="language" />
    <image py:if="value_of('image')">
        <title py:if="value_of('image', dict()).get('title', '')" py:content="image.title" />
        <link py:if="value_of('image', dict()).get('link', '')" py:content="image.link" />
        <url py:if="value_of('image', dict()).get('url', '')" py:content="image.url" />
    </image>
    <copyright py:if="value_of('copyright')" py:content="copyright" />
    <managingEditor py:if="value_of('managingEditor')" py:content="managingEditor" />
    <webMaster py:if="value_of('webMaster')" py:content="webMaster" />
    <category py:if="value_of('category')" domain="${value_of('category_domain')}" py:content="category" />
    <generator py:if="value_of('generator')" py:content="generator" />
    <docs py:if="value_of('docs')" py:content="docs" />
    
    <item py:for="i in value_of('items', [])">
        <title py:if="i.get('title', None)" py:content="i['title']" />
        <link py:if="i.get('link', None)" py:content="i['link']" />
        <description py:if="i.get('description', None)" py:content="i['description']" />
        <author py:if="i.get('author', None)" py:content="i['author']" />
        <category py:if="i.get('category', None)" py:content="i['category']" />
        <pubDate py:if="i.get('pubDate', None)" py:content="i['pubDate'].strftime('%a, %d %b %Y %H:%M:%S %Z')" />
        <guid py:if="i.get('guid', None)" py:content="i['guid']" isPermaLink="false" />
    </item>
</channel>
</rss>
