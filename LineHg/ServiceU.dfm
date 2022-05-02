object m33server: Tm33server
  OldCreateOrder = False
  DisplayName = 'm33'
  AfterInstall = ServiceAfterInstall
  OnContinue = ServiceContinue
  OnExecute = ServiceExecute
  OnPause = ServicePause
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 155
  Width = 241
end
