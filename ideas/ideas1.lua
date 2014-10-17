self:dispatch(MainAreaEvent:new(EVT_SWITCH_AREA_TO,"QiyuMainArea_QiyuMainArea",QiyuMainAreaMediator,AreaKindName.TRAIN_EXP_AREA))
 ItemEvent =  LuaEvent:subclass('ItemEvent')



self:dispatch(LuaEvent:new(EVT_USER_INIT,  data));
实例化了一个LuaEvent方法  方法类型type是EVT_USER_INIT  并传入了数据
设置当前的类型以及数据

LuaEvent =  DisposeObject:subclass('LuaEvent')
function LuaEvent:initialize(eventType,data)
    assert( type(eventType) == "number" , "eventType must be a number, now is " .. tostring(eventType).. tostring(debug.traceback()))
    self.eventType = eventType
    if data ~= nil then
        self.data = table.copy(data)
    end
end
function LuaEvent:dispose()
    super.dispose(self)
end

LuaEvent继承自DisposeObject


