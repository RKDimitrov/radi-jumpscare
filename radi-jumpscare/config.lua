Config = {}

Config.UseHeadbagTimeout = 3000 -- (milliseconds)

Config.Inventory = 'qb' -- 'qb', 'ox', 'none'

-- command to toggle headbag
Config.ToggleCommand = 'jumpscare' -- false: disable command
Config.ToggleCommandHelp = 'Put/remove headbag'

-- command to remove headbag
Config.RemoveCommand = 'removejumpscare' -- false: disable command
Config.RemoveCommandHelp = 'Remove Headbag'
Config.RemoveCommandKey = ']' -- key to remove headbag

-- notification language
Config.Lang = {
    ['no_one_nearby'] = 'No one nearby',
    ['use_timeout'] = 'Please wait before you try again',
    ['no_handup'] = 'Person\'s hands are down',
    ['no_headbag_onhead'] = 'Person doesnt have headbag on their head',
}
