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

function DisposeObject:getEventMap()
    if self.eventMap == nil then
        self.eventMap =   EventMap:new()
    end
    return self.eventMap
end

function DisposeObject:mapEventListener(dispatcher, type,  target , func, priority)
    self:getEventMap():mapListener(dispatcher, type,  target , func, priority)
end

function DisposeObject:unmapEventListener(dispatcher, type,  target , func)
    self:getEventMap():unmapListener(dispatcher, type,  target , func)
end

function DisposeObject:bindRetain(ccObject)
    local bindHash = self.bindObjectRetainHash;
    if bindHash == nil then
        bindHash={};
        self.bindObjectRetainHash = bindHash;
    end
    if bindHash[ccObject] == nil then
        bindHash[ccObject] =1
        ccObject:retain();
    else
        bindHash[ccObject] = bindHash[ccObject] +1;
    end

end


function DisposeObject:bindRelease(ccObject)
    local bindHash = self.bindObjectRetainHash;
    if bindHash == nil then
        return;
    end
    if bindHash[ccObject] == nil then
        return
    else
        bindHash[ccObject] = bindHash[ccObject] -1;
        if  bindHash[ccObject] ==0 then
            ccObject:release();
            bindHash[ccObject] = nil;
        end
    end
end

DisposeObject 有两个方法，mapEventListener和unmapEventListener
传入了dispatcher，事件类型、调用此事件的target、以及调用的事件类型。
dispatcher类是提供用于管理线程工作项队列的服务。 管理线程
getDispatcher  获取当前线程的dispatcher
getEventMap 实例化了一个EventMap实例

Eventmap = DisposeObject:subclass('EventMap')

function Eventmap:initialize()
    --dispatcher:retain()
    --self.dispatcher = dispatcher
    self.theMap={} --theMap maps  EventTagType to Array<EventMapNode>
end

function Eventmap:dispose()
    self:unmapListeners()
    self.theMap = nil
     super.dispose(self)
    --self.dispatcher:release()
    --self.dispatcher = nil
        super.dispose(self)
end

function Eventmap:mapListener(dispatcher, type,  target , func, priority)
    --[[
    if dispatcher == nil then
        return
    end
    --]]
    assert(dispatcher ~= nil ," Eventmap:mapListener : dispatcher should not be nil!");
    if priority == nil then
        priority = 0
    end
    local nodeList = self.theMap[type];
    if nodeList == nil then
        nodeList = {}
        self.theMap[type] = nodeList
    else
        for k in pairs(nodeList) do
            if k:isEqualNode(dispatcher,target,func)  then
                return
            end
        end
    end

    local newNode =   EventMapNode:new(dispatcher, target , func, priority)
    nodeList[newNode] = true;
    dispatcher:addEventListenerScript(type,target or 0 ,func,priority)
end

function Eventmap: unmapListener( dispatcher, type, target ,func)
    if dispatcher == nil or self.theMap[type] == nil then
        return
    end
    local nodeList = self.theMap[type];
    local delNode;
    for k in pairs(nodeList) do
        if k:isEqualNode(dispatcher,target,func)  then
            delNode= k
            break
        end
    end

    if delNode ~= nil then
        delNode.dispatcher:removeEventListenerScript(type,target or 0,func)
        nodeList[delNode] = nil
        delNode:dispose()
    end
end

function Eventmap: unmapListeners()
    for type in pairs(self.theMap) do
        local nodeList = self.theMap[type]
        for delNode in pairs(nodeList) do
            delNode.dispatcher:removeEventListenerScript(type,delNode.target or 0,delNode.func)
            delNode:dispose()
        end
    end
    self.theMap={}
end

Eventmap 的初始化方法中有一个空白的Map的表
调用mapEventListener方法时，判断传入的type是否在map表中，如果没在map
表中，则将该type的事件加入到map表中，并且给其赋值一个表nodelist
如果map表里有该类型，则进行原有nodelist与新传入nodelist进行对比，看是否一致
根据传入的参数创建一个EventMapNode，赋值给nodelist
并根据传入的dispatcher将该事件传入到listener中 addEventListenerScript

EVT_SYSTEM_LOGIN_BEGIN = InitStaticInt:getEventTypeFromStr("EVT_SYSTEM_LOGIN_BEGIN")
int playcrab::InitStaticInt::getEventTypeFromStr( const std::string str )
{	
	if(eventStrIntDict == NULL)
	{
		eventStrIntDict = new PCStringIntDict(10000);
	}
	int ret;
	eventStrIntDict->addString(str,&ret);
	return ret;
}
bool playcrab::PCStringIntDict::addString( const std::string & str, int * pInt )
{
    std::map<std::string,int>::const_iterator it = stringToInt.find(str);
	if(it != stringToInt.end())
	{
		*pInt = it->second;
		return false;
	}
	else
	{
        std::map<std::string,int>::iterator it = stringToInt.insert(std::make_pair(str, ++idCount)).first;
		intToString[idCount] = it->first.c_str();
		*pInt = idCount;
		return true;
	}
}

bool playcrab::PCStringIntDict::addString( const std::string & str )
{
	int temp;
    return addString(str, &temp);
}

std::map<std::string,int> stringToInt;
std::map<int,const char *> intToString;
通过此方法将其增加到一个容器里边

