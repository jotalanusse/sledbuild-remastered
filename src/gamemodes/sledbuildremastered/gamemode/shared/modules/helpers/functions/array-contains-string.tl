require("shared/modules/helpers/types/helpers")

-- ArrayContainsString: Returns true if the array contains the string.
function HELPERS.ArrayContainsString(array: {string}, value: string): boolean
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end

    return false
end
