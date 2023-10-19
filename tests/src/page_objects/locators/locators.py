# Home Page locators

# Input section
InputTitle = '//h5[contains(text(),"Input")]'
AddFilesButton = '//button[@id="addBtn"]'
RemoveButton = '//button[@id="removeBtn"]'
StartButton = '//button[@id="startBtn"]'
RadioButton = 'firstRadio'

EmptyListInfo = '//li[@id="emptyListInfo"]'

# Output section
OutputTitle = '//h5[contains(text(),"Output")]'
ExtractAndSaveButton = '//button[@id="extractBtn"]'
ExtractAndSaveDisabledButton = '//*[(@id = "extract-group")]//button[(@disabled)]'
FileDetails = '//small[@id="details"]'
FileSize = '//*[@id="size"]'
FileNum = '//*[@id="filesNum"]'
Description = '//*[@id="title"]'
ProgressBar = '//div[@id="progress-bar"]'

# Logs section
LogsTitle = '//div[@id="collapseLogs"]'
CollapseLogsButton = '//button[@id="logsButton"]'

LogsConsole = '//div[@id="collapseLogs"]'

# Popup notifications
# TODO add scenarios for Popup notifications

# Website footer sections
AboutButton = '//a[contains(text(),"About")]'
AboutSubpageText = '//div[@id="footer-group"]/div[@id="about"]'
KnownIssuesButton = '//a[contains(text(),"issues")]'
KnownIssuesText = '//div[@id="footer-group"]/div[@id="issues"]'
OpenSourceTechnologiesButton = '//a[contains(text(),"Open source technologies")]'
OpenSourceTechnologiesText = "//div[@id='techs']/ul"
GithubRepository = '//div[@id="footer"]//a[@class="collapse-name"][contains(text(),"Github")]'
ChangeThemeButton = 'id:themeSwitch'
