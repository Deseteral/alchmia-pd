--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
local function __TS__ArrayFindIndex(self, callbackFn, thisArg)
    for i = 1, #self do
        if callbackFn(thisArg, self[i], i - 1, self) then
            return i - 1
        end
    end
    return -1
end

local function __TS__CountVarargs(...)
    return select("#", ...)
end

local function __TS__ArraySplice(self, ...)
    local args = {...}
    local len = #self
    local actualArgumentCount = __TS__CountVarargs(...)
    local start = args[1]
    local deleteCount = args[2]
    if start < 0 then
        start = len + start
        if start < 0 then
            start = 0
        end
    elseif start > len then
        start = len
    end
    local itemCount = actualArgumentCount - 2
    if itemCount < 0 then
        itemCount = 0
    end
    local actualDeleteCount
    if actualArgumentCount == 0 then
        actualDeleteCount = 0
    elseif actualArgumentCount == 1 then
        actualDeleteCount = len - start
    else
        actualDeleteCount = deleteCount or 0
        if actualDeleteCount < 0 then
            actualDeleteCount = 0
        end
        if actualDeleteCount > len - start then
            actualDeleteCount = len - start
        end
    end
    local out = {}
    for k = 1, actualDeleteCount do
        local from = start + k
        if self[from] ~= nil then
            out[k] = self[from]
        end
    end
    if itemCount < actualDeleteCount then
        for k = start + 1, len - actualDeleteCount do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
        for k = len - actualDeleteCount + itemCount + 1, len do
            self[k] = nil
        end
    elseif itemCount > actualDeleteCount then
        for k = len - actualDeleteCount, start + 1, -1 do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
    end
    local j = start + 1
    for i = 3, actualArgumentCount do
        self[j] = args[i]
        j = j + 1
    end
    for k = #self, len - actualDeleteCount + itemCount + 1, -1 do
        self[k] = nil
    end
    return out
end
-- End of Lua Library inline imports
local ____exports = {}
function ____exports.generateRecipes(self)
    local recipes = {}
    local namePool = {table.unpack(POTION_NAMES)}
    do
        local recipeIdx = 0
        while recipeIdx < 15 do
            local recipeGood = false
            local recipeTries = 10
            while not recipeGood and recipeTries >= 0 do
                local ingredientCount = recipeIdx <= 5 and randomRange(nil, 1, 2) or randomRange(nil, 3, 5)
                local ingredients = {}
                do
                    local ingredientIdx = 0
                    while ingredientIdx < ingredientCount do
                        local ingredientGood = false
                        local ingredientTries = 10
                        while not ingredientGood and ingredientTries >= 0 do
                            local ingredientId = randomRange(nil, 0, #Ingredients - 1)
                            local actionId = randomRange(nil, 0, #IngredientActions - 1)
                            local pi = {ingredient = Ingredients[ingredientId + 1], action = IngredientActions[actionId + 1]}
                            local foundIdx = __TS__ArrayFindIndex(
                                ingredients,
                                function(____, pp) return preparedIngredientEquals(nil, pi, pp) end
                            )
                            if foundIdx == -1 then
                                ingredients[#ingredients + 1] = pi
                                ingredientGood = true
                            end
                            ingredientTries = ingredientTries - 1
                        end
                        ingredientIdx = ingredientIdx + 1
                    end
                end
                recipeTries = recipeTries - 1
                if findMatchingRecipe(nil, ingredients, recipes) == nil then
                    local nameIdx = randomRange(nil, 0, #namePool - 1)
                    local name = table.unpack(__TS__ArraySplice(namePool, nameIdx, 1))
                    recipes[#recipes + 1] = {name = name, ingredients = ingredients}
                    recipeGood = true
                end
            end
            recipeIdx = recipeIdx + 1
        end
    end
    print(
        ("generated " .. tostring(#recipes)) .. " recipes",
        recipes
    )
    return recipes
end
generateRecipes = ____exports.generateRecipes
return ____exports