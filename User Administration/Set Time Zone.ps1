Connect-MgGraph -Scopes User.ReadWrite.All, MailboxSettings.ReadWrite

## For just one user
$user = Get-MgUser -UserId "fzotelo@cod-school.com"

Update-MgUser -UserId $user.Id -MailboxSettings @{
  DateFormat = "MM/dd/yyyy"
  TimeFormat = "HH:mm:ss tt"
  TimeZone = "Central Standard Time"
  Language = @{
    DisplayName = "English (United States)"
    Locale = "en-US"
  }
  WorkingHours = @{
    DaysOfWeek = @("monday", "tuesday", "wednesday", "thursday", "friday")
    StartTime = "08:00:00"
    EndTime = "17:30:00"
    TimeZone = @{
      Name = "Central Standard Time"
    }
  }
}

Update-MgUserMailboxSetting -UserId 'fzotelo@cod-school.com' -TimeZone "Central Standard Time" -Language @{DisplayName = "English (United States)"; Locale = "en-us"} -DateFormat "MM/dd/yyyy" -TimeFormat "HH:mm:ss tt"

Update-MgUserMailboxSetting -InputObject @{UserId = $user.Id} -BodyParameter @{TimeZone = "Central Standard Time"; Language = @{DisplayName = "English (United States"; Locale = "en-us"}; DateFormat = "MM/dd/yyyy"; TimeFormat = "HH:mm:ss tt"}


$timeZone = "Central Standard Time"
$uri = "https://graph.microsoft.com/v1.0/users/$($user.Id)/mailboxSettings"
$jsonContent = "{""timeZone"":""$timeZone""}"
Invoke-MgGraphRequest -Uri $uri -Method PATCH -ContentType "application/json" -Body $jsonContent