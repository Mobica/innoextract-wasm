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
LoadedFileName = '//h5[@id="title"]'
DirectoryTree = '//div[@id="tree"]'

# Logs section
LogsTitle = '//div[@id="collapseLogs"]'
CollapseLogsButton = '//button[@id="logsButton"]'

LogsConsole = '//div[@id="collapseLogs"]'

# Popup notifications
ErrorPopup = 'id:errorModal'
ErrorPopupMsg = 'id:errorMsg'
ErrorPopupCloseBtn = 'xpath://button[contains(text(),"Close")]'

# Website footer section
AboutButton = '//a[contains(text(),"About")]'
AboutSubpageText = '//div[@id="footer-group"]/div[@id="about"]'
KnownIssuesButton = '//a[contains(text(),"issues")]'
KnownIssuesText = '//div[@id="footer-group"]/div[@id="issues"]'
OpenSourceTechnologiesButton = '//a[contains(text(),"Open source technologies")]'
OpenSourceTechnologiesText = "//div[@id='techs']/ul"
GithubRepository = '//div[@id="footer"]//a[@class="collapse-name"][contains(text(),"Github")]'
ChangeThemeButton = 'id:themeSwitch'

# Website header section
HeaderIcon = 'img/icon_64.png'
HeaderText = '//span[contains(text(),"Innoextract wasm")]'

# Options section
OptionsButton = '//button[@id="optsButton"]'
OptionsList = '//div[@id="collapseOpts"]'
EnableDebugSwitch = '//*[@id="optsEnableDebug"]'
ReloadBadge = '//*[@id="reloadBadge"]'
ExcludeTemporaryFilesSwitch = '//*[@id="optsExcludeTemporary"]'
OutputLogsSwitch = '//*[@id="optsLogsToFile"]'
LogsButton = '//span[contains(text(),"Logs")]'
DownloadLogsButton = '//span[contains(text(),"Download log")]'
ExtractionLangFilterOption = '//*[@id="extractionLanguageFilterOptions"]'
CollisionResolutionOption = 'collisionResolutionOptions'
