return {
   source_dir = "src",
   include_dir = {
      "src/gamemodes/sledbuildremastered/gamemode",

      "src/gamemodes/sledbuildremastered/gamemode/config",

      "src/gamemodes/sledbuildremastered/gamemode/server/modules/effects",
      "src/gamemodes/sledbuildremastered/gamemode/server/modules/net",
      "src/gamemodes/sledbuildremastered/gamemode/server/modules/npcs",
      "src/gamemodes/sledbuildremastered/gamemode/server/modules/ragdolls",
      "src/gamemodes/sledbuildremastered/gamemode/server/modules/sweps",
      "src/gamemodes/sledbuildremastered/gamemode/server/modules/uptime",
   },

   build_dir = "build",

   global_env_def = "declarations/declarations",

   gen_target = "5.1",
   gen_compat = "off",
}
