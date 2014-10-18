self.commandMap:mapEvent(EVT_LIBAO_REQUEST_INIT_BAIYI,RequestInitBaiyiCommand)
function CommandMap:initialize(eventDispatcher ,  injector, mediatorMap)
    self.eventDispatcher = eventDispatcher
    self.injector = injector
    self.mediatorMap = mediatorMap
    self.commandExecuteMap = {}
end

有一个commandExecuteMap的表，存储commandMap
function CommandMap:mapEvent(eventType, commandClass, isLoadFile,loadCommand,oneShoot)
	local executeInfoOb =   CommandExecuteInfo:new(commandClass,oneShoot,self,loadCommand)
    if self.commandExecuteMap[eventType]==nil then
        self.commandExecuteMap[eventType] = {}
    end

    self.commandExecuteMap[eventType][commandClass] = executeInfoOb
    self.eventDispatcher:addEventListenerScript(eventType,executeInfoOb,executeInfoOb.execute)
end
将事件类型以及commandclass添加到map中
