DeriveGamemode("sandbox")

GM.Name 	= "Sledbuild 3.4"
GM.Author 	= "G3X, robinkooli"
GM.Email 	= "robinkooli@live.fi"
GM.Website 	= "robinkooli.net"

//Team enumerations
TEAM_BUILDING = 2
TEAM_RACING   = 1

function setTeams()
	team.SetUp(TEAM_BUILDING,"Building",Color(80,80,255,255))
	team.SetUp(TEAM_RACING,"Racing",Color(255,80,80,255))
end

setTeams()