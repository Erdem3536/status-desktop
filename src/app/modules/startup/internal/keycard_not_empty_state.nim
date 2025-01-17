type
  KeycardNotEmptyState* = ref object of State

proc newKeycardNotEmptyState*(flowType: FlowType, backState: State): KeycardNotEmptyState =
  result = KeycardNotEmptyState()
  result.setup(flowType, StateType.KeycardNotEmpty, backState)

proc delete*(self: KeycardNotEmptyState) =
  self.State.delete

method executePrimaryCommand*(self: KeycardNotEmptyState, controller: Controller) =
  if self.flowType == FlowType.FirstRunNewUserNewKeycardKeys or
    self.flowType == FlowType.FirstRunNewUserImportSeedPhraseIntoKeycard:
      controller.runFactoryResetPopup()

method executeSecondaryCommand*(self: KeycardNotEmptyState, controller: Controller) =
  if self.flowType == FlowType.FirstRunNewUserNewKeycardKeys or
    self.flowType == FlowType.FirstRunNewUserImportSeedPhraseIntoKeycard:
      controller.runLoadAccountFlow()

method resolveKeycardNextState*(self: KeycardNotEmptyState, keycardFlowType: string, keycardEvent: KeycardEvent, 
  controller: Controller): State =
  let state = ensureReaderAndCardPresenceOnboarding(self, keycardFlowType, keycardEvent, controller)
  if not state.isNil:
    return state
  if self.flowType == FlowType.FirstRunNewUserNewKeycardKeys:
    if keycardFlowType == ResponseTypeValueEnterNewPIN and 
      keycardEvent.error.len > 0 and
      keycardEvent.error == ErrorRequireInit:
        return createState(StateType.KeycardCreatePin, self.flowType, self.getBackState)
  if self.flowType == FlowType.FirstRunNewUserImportSeedPhraseIntoKeycard:
    if keycardFlowType == ResponseTypeValueEnterNewPIN and 
      keycardEvent.error.len > 0 and
      keycardEvent.error == ErrorRequireInit:
        return createState(StateType.UserProfileEnterSeedPhrase, self.flowType, self.getBackState)