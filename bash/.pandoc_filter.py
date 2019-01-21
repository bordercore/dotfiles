#!/usr/bin/env python

"""
Pandoc filter to cleanup conversion of HTML pages to Markdown
"""

# import logging

from pandocfilters import toJSONFilter

# logging.basicConfig(filename="pandoc_filter.log",
#                     filemode='w',
#                     format='%(asctime)s,%(msecs)d %(name)s %(levelname)s %(message)s',
#                     datefmt='%H:%M:%S',
#                     level=logging.DEBUG)

# log = logging.getLogger(__name__)


def markdown_cleanup(key, value, format, meta):

    # if key == 'Str':
    #     log.info(b"value: {}, format={}, meta={}".format(str(value), format, meta))

    # Remove all images
    if key == "Image":
        return []


if __name__ == "__main__":
    toJSONFilter(markdown_cleanup)
