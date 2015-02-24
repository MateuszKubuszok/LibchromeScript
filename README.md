# Minimalist Chromium Base/libChrome builder

Downloads Chromium with several libraries, overrides some settings to avoid
building whole Chromium and generates ninja builders for target `base`.

It might get out of sync with Chromium very quickly but should compile as long
as `base`'s dependencies won't change.

Of course it requires depot_tools installed (or at least ninja)...
