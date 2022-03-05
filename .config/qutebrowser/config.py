# Load settings added with ui
# See <https://github.com/qutebrowser/qutebrowser/blob/master/doc/help/configuring.asciidoc#loading-autoconfigyml>
# See list of userscripts: https://github.com/qutebrowser/qutebrowser/blob/master/misc/userscripts/README.md
# To se all configuration type :set inside qutebrowser
config.load_autoconfig(True)

c.content.blocking.method = 'adblock'
c.content.blocking.adblock.lists = [
        'https://easylist.to/easylist/easylist.txt',
        'https://easylist.to/easylist/easyprivacy.txt',
        'https://easylist.to/easylist/fanboy-social.txt',
        'https://easylist-downloads.adblockplus.org/easylistdutch.txt',
        'https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt',
        'https://www.i-dont-care-about-cookies.eu/abp/',
        'https://secure.fanboy.co.nz/fanboy-cookiemonster.txt',
        'https://secure.fanboy.co.nz/fanboy-annoyance.txt',
        #'https://gitlab.com/curben/urlhaus-filter/-/raw/master/urlhaus-filter.txt',
        'https://pgl.yoyo.org/adservers/serverlist.php?showintro=0;hostformat=hosts',
        'https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt',
        'https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt',
        'https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt',
        'https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt',
        'https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt',
        'https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt',
        'https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt',
        'https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt',
        'https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt',
        'https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt'
]

# Search engines
c.url.searchengines = {
        "DEFAULT": "https://www.google.fi/search?q={}",
        #"DEFAULT": "https://duckduckgo.com/?q={}",
        "aw": "https://wiki.archlinux.org/?search={}",
        "gw": "https://wiki.gentoo.org/?search-{}",
        "yt": "https://youtube.com/results?search_query={}",
        "w": "https://en.wikipedia.org/?search={}",
        #"g": "https://www.google.fi/search?q={}",
        "dgi": "https://duckduckgo.com/?q=!ddgi {}",
        "tw": "twitter.com/{}",
        "dick": "http://en.wiktionary.org/?search={}",
        "r": "https://reddit.com/r/{}",
}

# Aliases
c.aliases = {
    "w": "session-save",
    "wq": "quit --save",
    "mpv": "spawn -d mpv --profile=H60 {url}",
    'gh': "open -t https://github.com/hoaxdream",
    'wh': "open -t https://alpha.wallhaven.cc/search?q=&categories=111&purity=100&topRange=1y&sorting=toplist&order=desc&colors=336600&page=1",
    'wt': "open -t https://www.webtoons.com/en/",
    'fb': "open -t https://facebook.com/",
    'ux': "open -t https://www.reddit.com/r/unixporn/",
    'tr': "open -t https://1337x.to/",
    'cc': "open -t https://jonasjacek.github.io/colors/",
    'od': "open -t https://odysee.com/",
    'bc': "open -t https://based.cooking/",
    'ax': "open -t https://animixplay.to/",
    'md': "open -t https://mp3quack.lol/",
    'suck': "open -t http://suckless.org/",
}

# Startpage
c.url.start_pages = ['~/.config/dev/startpage/index.html']
#c.url.start_pages = ['~/.config/qutebrowser/start.html']

# Enable this if using style2.css in startpage
#c.colors.webpage.darkmode.enabled = True  # This will break my startpage
#c.colors.webpage.preferred_color_scheme = 'dark'
#c.colors.webpage.bg = 'black'

# Not sure how this works for now, i'll test this if i had time lol.
#c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
#c.colors.webpage.darkmode.policy.images = 'smart'
#c.colors.webpage.darkmode.policy.page = 'smart'
#c.colors.webpage.darkmode.threshold.background = 0
#c.colors.webpage.darkmode.threshold.text = 256

# General settings
c.backend = 'webengine'                             # value: webengine, webkit
c.editor.command = ["st", "-e", "nvim '{}'"]
c.scrolling.smooth = False
c.qt.highdpi = False
c.confirm_quit = ['downloads']
c.completion.height = '20%'
c.completion.show = 'always'
c.hints.scatter = True
c.zoom.default = '140%'
c.auto_save.session = False
c.changelog_after_upgrade = 'never'
c.qt.force_software_rendering = 'software-opengl'
c.content.geolocation = 'ask'                       # value: true, false, ask
c.content.prefers_reduced_motion = True             # minimize non-essentials animations and motion in websites.
c.content.cookies.accept = 'all'
c.content.dns_prefetch = True
c.content.autoplay = True
c.content.pdfjs = True
c.content.fullscreen.overlay_timeout = 3000
c.content.fullscreen.window = True

# Tabs
c.tabs.last_close = 'close'
c.tabs.select_on_remove = 'prev'
c.tabs.new_position.unrelated = 'next'
c.tabs.position = 'top'

# Notification
c.content.notifications.enabled = 'ask'             # value: true, false, ask
c.content.notifications.presenter = 'libnotify'     # value: auto, qt, libnotify, systray, messages, herbe(experimental)
c.content.notifications.show_origin = True

# Downloads
c.downloads.location.directory = '~/.config/dl'
c.downloads.location.prompt = False
c.downloads.remove_finished = 1000

# Font and define colors values
c.fonts.default_family = ['Inconsolata']
c.fonts.default_size = '18px'
c.fonts.web.family.cursive = 'Inconsolata'
c.fonts.web.family.sans_serif = 'Inconsolata'
c.fonts.completion.category = 'bold default_size default_family'
c.fonts.contextmenu = '16px default_family'

# Colors
bg = "#1d2021"
fg = "#d4be98"
base01 = "#1d2021" # black
base02 = "#ea6962" # red
base03 = "#a9b665" # green
base04 = "#e78a4e" # yellow
base05 = "#7daea3" # blue
base06 = "#d3869b" # magenta
base07 = "#89b482" # cyan
base08 = "#d4be98" # white
base09 = "#32302f" # black
base10 = "#ea6962" # red
base11 = "#a9b665" # green
base12 = "#e78a4e" # yellow
base13 = "#7daea3" # blue
base14 = "#d3869b" # magenta
base15 = "#89b482" # cyan
base16 = "#d4be98" # white

# Context menu colors
c.colors.contextmenu.menu.bg = bg
c.colors.contextmenu.menu.fg = fg
c.colors.contextmenu.selected.bg = base05
c.colors.contextmenu.selected.fg = bg

# Completion colors
c.colors.completion.category.bg = base01                    # Background color of the completion widget category headers
c.colors.completion.category.border.bottom = base01         # Bottom border color of the completion widget category headers
c.colors.completion.category.border.top = base01            # Top border color of the completion widget category headers
c.colors.completion.category.fg = fg                        # Foreground color of completion widget category headers
c.colors.completion.even.bg = bg                            # Background color of the completion widget for even rows
c.colors.completion.odd.bg = bg                             # Background color of the completion widget for odd rows
c.colors.completion.fg = fg                                 # Text color of the completion widget
c.colors.completion.item.selected.bg = base05               # Background color of the selected completion item
c.colors.completion.item.selected.border.bottom = base09    # Bottom border color of the selected completion item
c.colors.completion.item.selected.border.top = base09       # Top border color of the completion widget category headers
c.colors.completion.item.selected.fg = base01               # Foreground color of the selected completion item
c.colors.completion.match.fg = base11                       # Foreground color of the matched text in the completion
c.colors.completion.scrollbar.bg = base01                   # Color of the scrollbar in completion view
c.colors.completion.scrollbar.fg = base09                   # Color of the scrollbar handle in completion view

# Downloads colors
c.colors.downloads.bar.bg = bg          # Background color for the download bar
c.colors.downloads.start.bg = bg        # Background color for active download bar
c.colors.downloads.start.fg = base04    # Foreground color for active download bar
c.colors.downloads.error.bg = base02    # Background color for downloads with errors
c.colors.downloads.error.fg = base01    # Foreground color for downloads with errors
c.colors.downloads.stop.bg = bg         # Color gradient stop for download backgrounds
c.colors.downloads.stop.fg = base11     # Color gradient stop for download foregrounds
c.colors.downloads.system.bg = 'none'   # Color gradient interpolation system for download backgrounds

# Hints colors
c.colors.hints.bg = bg                  # Background color for hints. use rgba value for transparency
c.colors.hints.fg = fg                  # Font color for hints
c.hints.border = '1px solid' + base01   # Hints
c.colors.hints.match.fg = base11        # Font color for the matched part of hints
c.colors.keyhint.bg = bg                # Background color of the keyhint widget
c.colors.keyhint.fg = fg                # Text color for the keyhint widget
c.colors.keyhint.suffix.fg = fg         # Highlight color for keys to complete the current keychain

# Info and error messages colors
c.colors.messages.error.bg = base02         # Background color of an error message
c.colors.messages.error.border = base10     # Border color of an error message
c.colors.messages.error.fg = base16         # Foreground color of an error message
c.colors.messages.info.bg = base01          # Background color of an info message
c.colors.messages.info.border = base01      # Border color of an info message
c.colors.messages.info.fg = base16          # Foreground color an info message
c.colors.messages.warning.bg = base06       # Background color of a warning message
c.colors.messages.warning.border = base12   # Border color of a warning message
c.colors.messages.warning.fg = base16       # Foreground color a warning message

# Prompt colors
c.colors.prompts.bg = base09                    # Background color for prompts
c.colors.prompts.border = '1px solid' + base01  # Border used around UI elements in prompts
c.colors.prompts.fg = fg                        # Foreground color for prompts
c.colors.prompts.selected.bg = bg               # Background color for the selected item in filename prompts

# Caret colors
c.colors.statusbar.caret.bg = bg            # Background color of the statusbar in caret mode
c.colors.statusbar.caret.fg = fg            # Foreground color of the statusbar in caret mode
c.colors.statusbar.caret.selection.bg = bg  # Background color of the statusbar in caret mode with a selection
c.colors.statusbar.caret.selection.fg = fg  # Foreground color of the statusbar in caret mode with a selection

# Statusbar colors
c.colors.statusbar.command.bg = base01              # Background color of the statusbar in command mode
c.colors.statusbar.command.fg = fg                  # Foreground color of the statusbar in command mode
c.colors.statusbar.command.private.bg = bg          # Background color of the statusbar in private browsing + command mode
c.colors.statusbar.command.private.fg = fg          # Foreground color of the statusbar in private browsing + command mode
c.colors.statusbar.insert.bg = base11               # Background color of the statusbar in insert mode
c.colors.statusbar.insert.fg = bg                   # Foreground color of the statusbar in insert mode
c.colors.statusbar.normal.bg = bg                   # Background color of the statusbar
c.colors.statusbar.normal.fg = fg                   # Foreground color of the statusbar
c.colors.statusbar.passthrough.bg = base05          # Background color of the statusbar in passthrough mode
c.colors.statusbar.passthrough.fg = base16          # Foreground color of the statusbar in passthrough mode
c.colors.statusbar.private.bg = bg                  # Background color of the statusbar in private browsing mode
c.colors.statusbar.private.fg = fg                  # Foreground color of the statusbar in private browsing mode
c.colors.statusbar.progress.bg = base16             # Background color of the progress bar
c.colors.statusbar.url.error.fg = base06            # Foreground color of the URL in the statusbar on error
c.colors.statusbar.url.fg = base16                  # Default foreground color of the URL in the statusbar
c.colors.statusbar.url.hover.fg = base09            # Foreground color of the URL in the statusbar for hovered links
c.colors.statusbar.url.success.http.fg = base11     # Foreground color of the URL in the statusbar on successful load
c.colors.statusbar.url.success.https.fg = base11    # Foreground color of the URL in the statusbar on successful load
c.colors.statusbar.url.warn.fg = base04             # Foreground color of the URL in the statusbar when there's a warning

# Status bar padding
c.statusbar.padding = {
    'top': 5,
    'right': 5,
    'bottom': 5,
    'left': 5,
}

# Tabs colors
c.colors.tabs.bar.bg = bg                   # Background color of the tab bar
c.colors.tabs.even.bg = bg                  # Background color of unselected even tabs
c.colors.tabs.even.fg = base16              # Foreground color of unselected even tabs
c.colors.tabs.indicator.error = base02      # Color for the tab indicator on errors
c.colors.tabs.indicator.start = base05      # Color gradient start for the tab indicator
c.colors.tabs.indicator.stop = base11       # Color gradient end for the tab indicator
c.colors.tabs.indicator.system = 'none'     # Color gradient interpolation system for the tab indicator
c.colors.tabs.odd.bg = bg                   # Background color of unselected odd tabs
c.colors.tabs.odd.fg = base16               # Foreground color of unselected odd tabs
c.colors.tabs.selected.even.bg = bg         # Background color of selected even tabs
c.colors.tabs.selected.even.fg = base11     # Foreground color of selected even tabs
c.colors.tabs.selected.odd.bg = bg          # Background color of selected odd tabs
c.colors.tabs.selected.odd.fg = base11      # Foreground color of selected odd tabs

# Tab padding
c.tabs.padding = {
    'top': 5,
    'right': 5,
    'bottom': 5,
    'left': 5,
}

c.tabs.indicator.width = 1
c.tabs.favicons.scale = 1.0

# Mappings
ESC_BIND = 'clear-keychain ;; search ;; fullscreen --leave'
c.bindings.commands['normal'] = {
'<ctrl-x>': ESC_BIND,
}

config.bind('<ctrl-x>', 'leave-mode')
config.bind("K", "tab-next")
config.bind("J", "tab-prev")
config.bind("O", "set-cmd-text :open {url:pretty}")
config.bind("T", "set-cmd-text :open -t {url:pretty}")
config.bind("t", "set-cmd-text -s :open -t")
config.bind("z+", "zoom-in")
config.bind("z-", "zoom-out")
config.bind("zz", "zoom")
config.bind("h", "scroll-px -300 0")
config.bind("j", "scroll-px 0 300")
config.bind("k", "scroll-px 0 -300")
config.bind("l", "scroll-px 300 0")
config.bind('ya', 'spawn ytubeaudio {url}')
config.bind('yv', 'spawn ytubevideo {url}')
config.bind("<Alt-f>", "hint links spawn --detach mpv --profile=M60 {hint-url}")
config.bind("<Alt-Shift-f>", "hint links spawn --detach mpv --profile=H60 {hint-url}")
#config.bind("<Alt-f>", "hint links spawn --detach mpv --force-window yes {hint-url}")

config.bind('<Escape>', 'leave-mode ;; jseval -q document.activeElement.blur()', mode='insert')
config.bind('<Ctrl-x>', 'leave-mode ;; jseval -q document.activeElement.blur()', mode='insert')

c.bindings.commands['hint'] = {
        # escape hatch
        '<ctrl-x>': 'leave-mode',
}

c.bindings.commands['caret'] = {
        # escape hatch
        '<ctrl-x>': 'leave-mode',
}

c.bindings.commands['prompt'] = {
        # escape hatch
        '<ctrl-x>': 'leave-mode',
}

c.bindings.commands['command'] = {
        # escape hatch
        '<ctrl-x>': 'leave-mode',
}

c.bindings.commands['insert'] = {
        # escape hatch
        '<ctrl-x>': 'leave-mode',
}
