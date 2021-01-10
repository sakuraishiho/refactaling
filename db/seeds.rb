clubs = [
    { name: "Manchester City FC",
      established_on: "1894",
      hometown: "Manchester",
      country: "England",
      color: 'blue',
      manager: "Pep Gualdiora" },
    { name: "Yokohama City FC",
      established_on: "1894",
      hometown: "Yokohama",
      country: "Japan",
      color: "blue",
      manager: "Pep Gualdiora" },
    { name: "Liverpool FC",
      established_on: "1894",
      hometown: "Liverpool",
      country: "England",
      color: "Red",
      manager: "Julgen Klopp" },
    { name: "Chealsea FC",
      established_on: "1894",
      hometown: "London",
      country: "England",
      color: "Blue",
      manager: "Frank Lampard" }
]

clubs.each { |club| Club.create!(club) }

leagues = [
    { name: 'Premier League',
      country: 'England' },
    { name: 'J1 League',
      country: 'Japan' },
]

leagues.each { |league| League.create!(league) }

players = [
  { firstname: 'Taro',
    lastname: 'Tanaka',
    position: 'MF',
    country: 'Japan',
    birthday: Date.new(1989, 1, 1),
    club: Club.first },
    { firstname: 'Jiro',
    lastname: 'Suzuki',
    position: 'FW',
    country: 'USA',
    birthday: Date.new(1975, 1, 1),
    club: Club.first },
]

players.each { |player| Player.create!(player) }

matches = [
  { kicked_off_at: Date.new(2021, 1, 29),
    league_id: 1,
    home_team: Club.first,
    away_team: Club.last,
    home_team_score: 3,
    away_team_score: 1 },
  { kicked_off_at: Date.new(2021, 1, 30),
    league_id: 1,
    home_team: Club.first,
    away_team: Club.last,
    home_team_score: 1,
    away_team_score: 1 },
  { kicked_off_at: Date.new(2021, 1, 31),
    league_id: 1,
    home_team: Club.first,
    away_team: Club.last,
    home_team_score: 0,
    away_team_score: 1 },
  { kicked_off_at: Date.new(2021, 1, 31),
    league_id: 1,
    home_team: Club.last,
    away_team: Club.first,
    home_team_score: 0,
    away_team_score: 1 }

]

matches.each { |match| Match.create!(match) }
