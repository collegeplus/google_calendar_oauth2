# Changelog

## 0.4.0 - 2015-08-14

### Added
- Calendar#find_by_summary allows users to find a calender by its summary. (The summary is what we think of as the calendar name).

### Changes
- Calendar#find expects a calendar_id instead of the summary.

## 0.3.2 - 2014-09-25

### Fixed
  - Events#update only takes an event object. Fixes the `undefined merge` error.

## 0.3.1 - 2014-07-08

### Fixed
- Events can be updated more than once now.

## 0.3.0 - 2014-07-08

### Added
- Added `application_name` and `application_version` to Client initialization.

### Deprecated
- Changed `Client#redirect_to` to `Client#authorization_uri`.

## 0.2.0 - 2014-07-03

### Removed
- `Event#create` and `Event#delete` now only take the calendar_id as an agrument instead of the entire calendar object.
