return {
   source_dir = "src",
   include_dir = {
      "src/gamemodes/sledbuildremastered/gamemode",
      "src/gamemodes/sledbuildremastered/gamemode/server/modules/uptime",
   },

   build_dir = "build",

   global_env_def = "declarations/declarations",

   gen_target = "5.1",
   gen_compat = "off",
}
