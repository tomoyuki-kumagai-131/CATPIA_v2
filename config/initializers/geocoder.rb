# frozen_string_literal: true

Geocoder.configure(

  # street address geocoding service (default :nominatim)
  lookup: :google,

  # IP address geocoding service (default :ipinfo_io)
  # ip_lookup: :maxmind,
  use_https: true,

  # to use an API key:
  api_key: 'AIzaSyAh_mxXXCr5aAy-KrOHfg_q3SZsxNiwHPg',

  # geocoding service request timeout, in seconds (default 3):
  timeout: 5,

  # set default units to kilometers:
  units: :km
)
