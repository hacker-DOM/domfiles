function getCurrentFileName()
    local info = debug.getinfo(1, "S")
    function getFileName(file)
        return file:match("[^/]*.lua$")
    end

    return getFileName(info.source)
end

function startswith(str, sub)
    return string.sub(str, 1, string.len(sub)) == sub
end

function getElWithOffset(list, el, offs)
    local idx = hs.fnutils.indexOf(list, el)
    return list[idx + offs]
end

function no(msg)
    hs.notify.show('Hammerspoon', '', msg)
end

S   = {'shift'}
C   = {'ctrl'}
CS  = {'ctrl', 'shift'}
A   = {'alt'}
AS  = {'alt', 'shift'}
M   = {'cmd'}
SM  = {'shift', 'cmd'}
CA  = {'ctrl', 'alt'}
CAS = {'cltr', 'alt', 'shift'}
CM  = {'ctrl', 'cmd'}
CSM = {'ctrl', 'shift', 'cmd'}
AM  = {'alt', 'cmd'}
ASM = {'alt', 'shift', 'cmd'}
CAM = {'ctrl', 'alt', 'cmd'}
CASM= {'ctrl', 'alt', 'shift', 'cmd'}

function indexOfEl(tbl, search)
    for index, value in ipairs(tbl) do
        if value == search then
            return index
        end
    end
    return nil -- return nil if the table is not found
end
