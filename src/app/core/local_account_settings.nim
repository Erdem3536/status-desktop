import NimQml, os

import ../../constants

# Local Account Settings keys:
const LS_KEY_STORE_TO_KEYCHAIN* = "storeToKeychain"
# Local Account Settings values:
const LS_VALUE_STORE* = "store"
const LS_VALUE_NOTNOW* = "notNow"
const LS_VALUE_NEVER* = "never"

QtObject:
  type LocalAccountSettings* = ref object of QObject
    settingsFileDir: string
    settings: QSettings
    
  proc setup(self: LocalAccountSettings) =
    self.QObject.setup
    self.settingsFileDir = os.joinPath(DATADIR, "qt")

  proc delete*(self: LocalAccountSettings) =
    if(not self.settings.isNil):
      self.settings.delete

    self.QObject.delete

  proc newLocalAccountSettings*(): 
    LocalAccountSettings =
    new(result, delete)
    result.setup

  proc setFileName*(self: LocalAccountSettings, fileName: string) =
    if(not self.settings.isNil):
      self.settings.delete

    let filePath = os.joinPath(self.settingsFileDir, fileName)
    self.settings = newQSettings(filePath, QSettingsFormat.IniFormat)

  proc storeToKeychainValueChanged*(self: LocalAccountSettings) {.signal.}

  proc removeKey*(self: LocalAccountSettings, key: string) =
    if(self.settings.isNil):
      return
    
    self.settings.remove(key)

    if(key == LS_KEY_STORE_TO_KEYCHAIN):
      self.storeToKeychainValueChanged()

  proc getStoreToKeychainValue*(self: LocalAccountSettings): string {.slot.} =
    if(self.settings.isNil):
      return ""

    self.settings.value(LS_KEY_STORE_TO_KEYCHAIN).stringVal

  proc setStoreToKeychainValue*(self: LocalAccountSettings, value: string) {.slot.} =
    if(self.settings.isNil):
      return

    self.settings.setValue(LS_KEY_STORE_TO_KEYCHAIN, newQVariant(value))
    self.storeToKeychainValueChanged()

  QtProperty[string] storeToKeychainValue:
    read = getStoreToKeychainValue
    write = setStoreToKeychainValue
    notify = storeToKeychainValueChanged