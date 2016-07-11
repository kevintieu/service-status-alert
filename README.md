## Service Status Alert

Basic PowerShell script for monitoring the status of a Windows service. If service is stopped, send a notification email. Intended to be used with Task Scheduler for recurring checks. If service is running, checks a target file (usually log file) and compares the modified date to the current date. If they do not match, send a notification email.
