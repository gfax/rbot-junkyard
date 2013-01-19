# coding: UTF-8
#
# :title: Brawl!
#
# Author:: Lite <degradinglight@gmail.com>
# Copyright:: (C) 2012 gfax.ch
# License:: GPL
# Version:: 2013-01-18
#
# TODO: Fix crashing when dropping player in a 3+ player game.

class Brawl

  MAX_HP = 10

  class Card

    attr_reader :name, :health, :skips, :string, :type

    def initialize(id)
      @name = id.downcase
      case @name
      when 'block'
        @type = :counter
        @string = "%{p} blocks %{o}'s %{c}."
      when 'dodge'
        @type = :counter
        @string = "%{p} dodges %{o}'s %{c}."
      when 'grab'
        @type = :counter
        @string = "%{p} grabs %{o}. Respond or pass, %{o}."
      when 'pillow'
        @type = :counter
        @health = 2
        @string = "%{p} holds up a pillow in defense."
      when 'insurance'
        @type = :counter
        @health = 5
        @string = "%{p} uses health insurance and " +
                  "is restored to #{@health} health!"
      when 'humiliation'
        @type = :attack
        @string = "%{p} psychologically devastates %{o} with deep humiliation."
        @skips = 2
      when 'eye poke'
        @type = :attack
        @health = -2
        @string = "%{p} pokes out %{o}'s eye. ;("
        @skips = 1
      when 'gutpunch'
        @type = :attack
        @health = -2
        @string = "%{p} punches %{o} in the guts."
      when 'nose bleed'
        @type = :attack
        @health = -3
        @string = "%{p} pops %{o} in the nose, spraying blood everywhere."
        @skips = 1
      when 'neck punch'
        @type = :attack
        @health = -3
        @string = "%{p} delivers %{o} a punch in the neck."
      when 'kickball'
        @type = :attack
        @health = -4
        @string = "%{p} delivers %{o}'s private belongings a swift kick."
      when 'uppercut'
        @type = :attack
        @health = -5
        @string = "%{o} receives an uppercut from %{p}."
      when 'slot machine'
        @type = :attack
        @string = "Next time stick to the pachinkos, %{o}."
      when 'trip'
        @type = :unstoppable
        @string = "%{p} trips %{o}."
        @skips = 1
      when 'trout slap'
        @type = :unstoppable
        @health = -1
        @string = "%{p} slaps %{o} around a bit with a large trout."
        @skips = -1
      when 'a gun'
        @type = :unstoppable
        @health = -2
        @string = "%{p} shoots %{o} in the FACE."
      when 'tire iron'
        @type = :unstoppable
        @health = -3
        @string = "%{p} whacks %{o} upside the head with a tire iron."
      when 'flipper'
        @type = :unstoppable
        case rand(2)
        when 0
          @string = "%{p} flips over the table, knocking " +
                    "all the cards out of %{o}'s hand."
        when 1
          @string = "%{p} violently SLAPS the cards " +
                    "out of %{o}'s hand for no raisin."
        end
      when 'garbage man'
        @type = :unstoppable
        @string = "%{p} dumps a bunch of garbage cards on %{o}."
      when 'heal steal'
        @type = :unstoppable
        @string = "%{p} rummages through %{o}'s hand for soup and pills."
      when 'soup'
        @type = :support
        @health = 1
        @string = "%{p} sips on some soup and relaxes."
      when 'pills'
        @type = :support
        @health = 2
        @string = "%{p} popped some pills!"
      when 'armor'
        @type = :support
        @health = 5
        @string = "%{p} buckles on some armor."
      when 'white wedding'
        @type = :support
        @health = MAX_HP - 1
        @string = "It's a nice day to... START AGAIN!!! HEALTH RESTORED!!!"
      when 'deflector'
        @type = :power
        @string = "%{p} raises a deflector shield!"
      when 'ffffff'
        @type = :power
        @health = -6
        @string = "%{p} randomly inflicts 6 damage on %{o}. What a dick!"
      when 'fireball'
        @type = :power
        @health = -1
        @string = "%{p} drops a fireball on everyone."
      when 'it\'s getting windy'
        @type = :power
        @string = "%{p} turns up the ceiling fan too high and blows up " +
                  "a gust! Every player passes a random card forward."
      when 'multi-ball'
        @type = :power
        @string = "%{p} lites multi-ball."
      when 'shifty business'
        @type = :power
        @string = "%{p} swaps hands with %{o}!"
      when 'the bees'
        @type = :power
        @string = "%{p} drops the bee cage on %{o}'s head..."
      when 'whirlwind'
        @type = :power
        @string = "FEEL THE POWER OF THE WIND"
      when 'you\'re your grandfather'
        @type = :power
        @string = "%{p} reverses the table!"
      else
        raise 'Invalid card name.'
        return
      end
      @health = 0 if @health.nil?
      @skips = 0 if @skips.nil?
    end

    def color
      case type
      when :counter
        Irc.color(:white,:black)
      when :attack
        Irc.color(:yellow,:black)
      when :unstoppable
        Irc.color(:olive,:black)
      when :support
        Irc.color(:teal,:black)
      when :power
        Irc.color(:brown,:black)
      end
    end

    def to_s
      hs = if health.zero? then ''
           elsif health < 0 then Irc.color(:red) + health.to_s
           else Irc.color(:blue) + '+' + health.to_s
           end
      case name
      when 'ffffff', 'the bees'
        Bold + color + " #{name.upcase} #{hs}" + NormalText
      else
        card_name = name.split(' ').each{|w| w.capitalize!}.join(' ')
        Bold + color + " #{card_name} #{hs}" + NormalText
      end
    end

  end


  class Player

    attr_reader :user
    attr_accessor :bees, :cards, :deflector, :discard, :damage,
                  :garbage, :grabbed, :health, :multiball, :skips

    def initialize(user)
      @user = user       # p.user => unbolded, p.to_s => bolded
      @bees = false      # player is attacked by bees when true
      @cards = []        # hand cards
      @damage = 0        # total damage dished out
      @deflector = false # deflects attacks when true
      @discard = nil     # card the player just played
      @garbage = nil     # array of Garbage Man garbage cards
      @grabbed = false   # currently being grabbed
      @health = MAX_HP   # initial health
      @multiball = false # gets to go again when true
      @skips = 0         # skips player when > 0
    end

    def delete_cards(request)
      request = [request] unless request.is_a?(Array)
      request.each do |r|
        # Grab an updated copy of the cards
        # array before starting each iteration.
        c = cards.dup
        n = 0
        n += 1 until c[n].name == r.name
        @cards.delete_at(n)
      end
    end

    def sort_cards
      # .to_s => sorts by color then name
      @cards = cards.sort {|x,y| x.to_s <=> y.to_s }
    end

    def to_s
      if deflector
        d1 = Irc.color(:brown) + "<" + NormalText
        d2 = Irc.color(:brown) + ">" + NormalText
      else
        d1 = ''
        d2 = ''
      end
      d1 + Bold + @user.to_s + Bold + d2
    end

  end


  BRAWL = Bold + "Brawl!" + Bold

  attr_reader :attacked, :deck, :discard, :dropouts, :channel,
              :registry, :reverse, :manager, :players, :turn

  def initialize(plugin, channel, registry, manager)
    debug "BRAWL STARTED"
    @channel = channel
    @plugin = plugin
    @bot = plugin.bot
    @attacked = nil   # player being attacked
    @deck = []        # card stock
    @discard = []     # used cards
    @dropouts = []    # users that aren't allowed to rejoin
    @manager = manager
    @players = []     # players currently in game
    @registry = registry
    @reverse = false  # true when player reverses playing order
    @turn = nil       # player number
    create_deck
    add_player(manager)
  end

  def say(msg, opts={})
    @bot.say channel, msg, opts
  end

  def notify(player, msg, opts={})
    @bot.notice player.user, msg, opts
  end

  def create_deck
    10.times do
      @deck << Card.new('gutpunch')
      @deck << Card.new('neck punch')
    end
    8.times do
      @deck << Card.new('grab')
      @deck << Card.new('pills')
    end
    7.times do
      @deck << Card.new('kickball')
    end
    6.times do
      @deck << Card.new('block')
      @deck << Card.new('dodge')
    end
    5.times do
      @deck << Card.new('uppercut')
    end
    3.times do
      @deck << Card.new('eye poke')
      @deck << Card.new('soup')
      @deck << Card.new('pillow')
    end
    2.times do
      @deck << Card.new('a gun')
      @deck << Card.new('trout slap')
      @deck << Card.new('nose bleed')
      @deck << Card.new('insurance')
      @deck << Card.new('trip')
      @deck << Card.new('heal steal')
      @deck << Card.new('humiliation')
      @deck << Card.new('slot machine')
      @deck << Card.new('surgery')
    end
    1.times do
      @deck << Card.new('armor')
      @deck << Card.new('deflector')
      @deck << Card.new('ffffff')
      @deck << Card.new('fireball')
      @deck << Card.new('flipper')
      @deck << Card.new('garbage man')
      @deck << Card.new('it\'s getting windy')
      @deck << Card.new('multi-ball')
      @deck << Card.new('tire iron')
      @deck << Card.new('shifty business')
      @deck << Card.new('the bees')
      @deck << Card.new('whirlwind')
      @deck << Card.new("reverse")
    end
    @deck.shuffle!
  end

  def deal(player, n=1)
    if deck.length < n
      n -= deck.length
      cards = @deck.pop(deck.length)
      @deck = @discard.dup
      @discard = []
      @bot.action channel, "shuffles the deck."
      @deck.shuffle!
      cards |= @deck.pop(n)
    else
      cards = @deck.pop(n)
    end
    unless turn.nil?
      notify player, "#{Bold}You drew:#{Bold} #{cards.join(', ')}"
    end
    player.cards |= cards
    player.sort_cards
  end

  def start_game
    # Pick a random player to start with.
    @turn = rand(players.length)
    say p_turn
    players.each do |p|
      notify p, p_cards(p)
    end
  end

  def add_player(user)
    if p = get_player(user)
      say "You're already in the game, #{p}."
      return
    end
    @dropouts.each do |dp|
      if dp.user == user
        say "You were dropped from the game, #{dp}. You can't get back in."
        return
      end
    end
    p = Player.new(user)
    @players << p
    if user == manager
      say "#{p} starts a #{BRAWL} Type 'j' to join."
    else
      say "#{p} joins the #{BRAWL}"
    end
    deal(p, 5)
    if players.length == 2
      countdown = @bot.config['brawl.countdown']
      @bot.timer.add_once(countdown) { start_game }
      say "Game will start in #{Bold}#{countdown}#{Bold} seconds."
    end
  end

  def drop_player(player, killed=false)
    if attacked
      attacked.discard = nil
      attacked.grabbed = nil
    end
    if player == players[turn]
      increment_turn
    end
    if killed
      player.damage = 0
      update_user_stats(player, 0)
      died = [ "%{p}'s soul has passed on.",
               "%{p} died.",
               "R.I.P. %{p}. Too soon.",
               "%{p} fell victim to HURT disease.",
               "%{p} expired.",
               "%{p} has been summoned by the Eternal Judge.",
               "%{p}: Loser even unto death.",
               "%{p}'s ded.",
               "%{p} was discharged from mortality.",
               "%{p} has foregone the finer things in life, like winning.",
               "Better luck next time, %{p} ...fgt.",
               "%{p} has gone upstream with the salmon.",
               "%{p} left the stage.",
               "%{p} is broken beyond repair. Nice work, ANDY.",
               "%{p} perished.",
               "Fatal racing crash. Car flipped about 2,457 times. " +
               "No survivors. %{p} was killed on impact. R.I.P."
             ].sample
      say died % { :p => player }
    else
      say "#{player} has been removed from the game."
    end
    @discard |= player.cards
    @dropouts << player
    @players.delete(player)
    end_game if players.length == 1
  end

  def get_player(user)
    case user
    when User
      players.each do |p|
        return p if p.user == user
      end
    when String
      players.each do |p|
        return p if p.user.irc_downcase == user.irc_downcase(channel.casemap)
      end
    else
      get_player(user.to_s)
    end
    return nil
  end

  def has_turn?(src)
    return false if turn.nil?
    return true if src == players[turn].user
    return false
  end

  def p_cards(player)
    n = 0
    c = Bold + Irc.color(:white,:black)
    cards = player.cards.map { |k| n += 1; "#{c}#{n}.\)#{Bold}#{k}"}
    return cards.join(" ")
  end

  def p_damage
    string = "Damage done -"
    players.each do |p|
      string << "- #{p}: #{p.damage} "
    end
    return string
  end

  def p_health(player=nil)
    unless player.nil?
      return "#{player}: #{player.health}"
    end
    string = "Health left -"
    @players.each do |p|
      string << "- #{p}: #{p.health} "
    end
    return string
  end

  def p_order
    a = players.dup
    a.reverse! if reverse
    p = a.first
    until p == players[turn]
      e = a.shift
      a << e
      p = a.first
    end
    string = "Playing order: "
    string << a.join(', ')
    return string
  end

  def p_turn
    player = players[turn]
    return "It's #{player}'s turn."
  end

  def check_health(player=nil)
    unless player.nil?
      drop_player(player, true) if player.health < 1
      return
    end
    players.each do |p|
      drop_player(p, true) if p.health < 1
    end
  end

  def discard(msg)
    player = players[turn]
    if attacked
      say "You can only discard at the start of your turn."
      return
    end
    a = msg.split(' ')
    return if a.length < 2
    a.delete_at(0) # [ "discard, "2", "4" ] => [ "2", "4" ]
    c = []
    a.uniq!
    a.each do |e|
      n = e.to_i
      if n < 1
        notify player, "Specify a card number."
        return
      end
      # Numbers are converted into cards.
      c << player.cards[n-1].dup
      if e.nil?
        notify player, "You don't even have #{n} cards."
        return
      end
    end
    player.delete_cards(c)
    s = if c.length == 1 then "" else "s" end
    say "#{player} discards #{c.length} card#{s}."
    deal(player, c.length)
    increment_turn
  end

  def pass(player)
    unless attacked
      say "Play or discard."
      return
    end
    if attacked.discard
      if player == players[turn]
        do_move(attacked, players[turn], wait=false)
      end
    end
    if players[turn].discard
      if player == attacked
        do_move(players[turn], attacked, wait=false)
      end
    end
    increment_turn
  end

  def play_move(a)
    player = players[turn]
    # Figure out who player is attacking, if anybody.
    if players.length == 2
      # If just two players are playing, the opponent
      # is assumed to be the player not attacking.
      if turn == 1
        opponent = players[0]
      else
        opponent = players[1]
      end
    else
      if attacked
        opponent = attacked
      else
        # Don't really need an opponent if power/support card.
        temp_card = a[0].to_i - 1
        if temp_card.between?(0, player.cards.length-1)
          temp_card = player.cards[temp_card]
          if temp_card.type == :power or temp_card.type == :support
            opponent = players[next_turn]
          else
            opponent = get_player(a[0])
            if opponent.nil?
              say "There is no player '#{a[0]}'."
              return
            end
            a.delete_at(0)
          end
        else
          opponent = get_player(a[0])
          if opponent.nil?
            say "There is no player '#{a[0]}'."
            return
          end
          a.delete_at(0)
        end
        if player == opponent
          say "You can't fight the mentally impaired."
          return
        end
      end
    end
    c = []
    a.uniq!
    a.each do |e|
      n = e.to_i
      if n < 1
        notify player, "Specify a card number."
        return
      end
      # Numbers are converted into cards.
      c << player.cards[n-1].dup
      if e.nil?
        notify player, "You don't even have #{n} cards."
        return
      end
    end
    if player.grabbed
      if player.discard
        say "You already played a card."
        return
      end
      # Player responds to a counter grab.
      do_counter(player, opponent, c)
      return
    end
    if c[0].type == :counter
      if c[0].name == 'grab'
        if c[1].nil?
          notify player, "Play an attack when grabbing."
          return
        end
        if c[1].type == :counter or c[1].type == :power
          notify player, "You can't play a #{c[1].type} card when grabbing."
          return
        end
        if c[1].name == 'white wedding'
          unless player.health == 1
            notify player, "You can only use that card with 1 health."
            return
          end
        end
        @discard |= [ c[0], c[1] ]
        player.discard = c[1]
        if player.discard.name == 'garbage man'
          player.garbage = c[2..-1]
        end
        player.delete_cards([c[0], c[1]])
        @attacked = opponent
        opponent.grabbed = true
        say c[0].string % { :p => player, :o => opponent }
        notify opponent, p_cards(opponent)
        return
      else
        notify player, "That's not an attack card."
        return
      end
    elsif c[0].type == :power
      do_power(player, c[0])
      return
    else
    end
    # Play the card
    if c[0].name == 'white wedding'
      unless player.health == 1
        notify player, "You can only use that card with 1 health."
        return
      end
    end
    @discard << c[0]
    player.discard = c[0]
    if player.discard.name == 'garbage man'
      player.garbage = c[1..-1]
    end
    player.delete_cards(c[0])
    do_move(player, opponent)
    increment_turn if c[0].type == :support or c[0].type == :unstoppable
  end

  def play_counter(player, a)
    c = []
    a.uniq!
    a.each do |e|
      n = e.to_i
      if n < 1
        notify player, "Specify a card number."
        return
      end
      # Numbers are converted into cards.
      c << player.cards[n-1].dup
      if e.nil?
        notify player, "You don't even have #{e} cards."
        return
      end
    end
    if c[0].type == :power
      do_power(player, c[0])
      return
    end
    if player.discard
      say "You already played a card."
      return
    end
    unless player == attacked
      notify player, "Wait your turn, #{player.user}."
      return
    end
    opponent = players[turn]
    do_counter(player, opponent, c)
  end

  def do_power(player, card)
    unless attacked.nil?
      say "You cannot play power cards in the middle of an attack, #{player}."
      return
    end
    @discard << card
    player.delete_cards(card)
    case card.name
    when 'deflector'
      player.deflector = true
      say card.string % { :p => player }
    when 'ffffff'
      victim = players[rand(players.length)]
      victim.health += card.health
      player.damage += card.health.abs
      say card.string % { :p => player, :o => victim }
      say p_health(victim)
      check_health(victim)
    when 'fireball'
      say card.string % { :p => player }
      players.each do |p|
        p.health += card.health
        player.damage += card.health.abs
      end
      say p_health
      check_health
    when 'it\'s getting windy'
      say card.string % { :p => player }
      temp_deck = []
      players.each do |p|
        c = p.cards[rand(p.cards.length)]
        temp_deck << c
        p.delete_cards(c)
      end
      n = 0
      temp_deck.each do |e|
        @players[next_turn(n)].cards << e
        n += 1
      end
    when 'multi-ball'
      player.multiball = true
      say card.string % { :p => player }
    when 'shifty business'
      n = rand(players.length)
      while players[n] == player
        n = rand(players.length)
      end
      say card.string % { :p => player, :o => players[n] }
      player.cards, players[n].cards = players[n].cards, player.cards
      notify(player, p_cards(player)) unless player == players[turn]
    when 'the bees'
      n = rand(players.length)
      players[n].bees = true
      say card.string % { :p => player, :o => players[n] }
    when 'whirlwind'
      temp_deck = []
      players.each do |p| 
        temp_deck << p.cards 
      end
      n = 0
      temp_deck.each do |h|
        @players[next_turn(n)].cards = h
        n += 1
      end
      say card.string % { :p => player }
      notify(player, p_cards(player)) unless player == players[turn]
    when "you're your grandfather"
      @reverse = if reverse then false else true end
      say card.string % { :p => player }
      if players.length == 2 and player != players[turn]
        increment_turn
        return
      end
    end
    
    # In the rare event the player (or current player) has no 
    # more cards, pass to the next player.
    increment_turn if players[turn].cards.length == 0
    
    notify player, p_cards(player)
  end

  def do_move(player, opponent, wait=true)
    # Exercise deflectors.
    if opponent.deflector and player.discard.type != :support
      n = rand(players.length)
      while players[n] == opponent
        n = rand(players.length)
      end
      say "#{opponent} deflects #{player}'s attack!"
      opponent.deflector = false
      players[n].health += player.discard.health
      player.damage += player.discard.health.abs
      players[n].skips += player.discard.skips
      say player.discard.string % { :p => player, :o => players[n] }
      say p_health(players[n])
      check_health(players[n])
      if opponent.grabbed == false and player.discard.type != :unstoppable
        increment_turn
      end
      return
    end
    case player.discard.type
    when :attack
      if wait
        say "#{player} plays #{player.discard}. Respond or pass, #{opponent}."
        notify opponent, p_cards(opponent)
        @attacked = opponent
        return
      end
      damage = 0
      # Determine amount of damage.
      if player.discard.name == 'slot machine'
        string = "#{player} pulls #{opponent}'s lever..."
        3.times do
          n = rand(4)
          string << " #{n}."
          damage -= n
        end
        say string
      else
        damage += player.discard.health
      end
      # Adjust damage depending if opponent has a pillow.
      if opponent.discard
        if opponent.discard.name == 'pillow'
          damage += opponent.discard.health
          damage = 0 if damage > 0
          say opponent.discard.string % { :p => opponent, :o => player }
        end
      end
      opponent.health += damage
      player.damage += damage.abs
    when :support
      player.health += player.discard.health
      if player.health > MAX_HP
        unless player.discard.name == 'armor'
          player.health = MAX_HP
        end
      end
      if player.bees
        say "#{player} recovers from bee allergies."
        player.bees = false
      end
    when :unstoppable
      if opponent.discard
        if opponent.discard.type == :counter
          say "#{opponent}'s counter was thwarted!"
        end
      end
      case player.discard.name
      when 'flipper'
        until opponent.cards.length < 1
          temp_deck = opponent.cards
          temp_deck.each do |c|
            @discard << c
            opponent.delete_cards(c)
          end
        end
      when 'garbage man'
        @discard |= player.garbage
        opponent.cards |= player.garbage
        player.delete_cards(player.garbage)
        player.garbage = nil
      when 'heal steal'
        h, temp_deck = player.health, []
        opponent.cards.each do |e|
          if e.name == 'soup' or e.name == 'peelz'
            temp_deck << e
            h += e.health
          end
        end
        if temp_deck.length > 0
          opponent.delete_cards(temp_deck)
          if h <= MAX_HP
            player.health = h
          elsif player.health <= MAX_HP
            if h > MAX_HP
              player.health = MAX_HP
            else
              player.health = h
            end
          else
          end
        end
      else
        opponent.health += player.discard.health
        player.damage += player.discard.health.abs
      end
    end
    # Announce attack
    say player.discard.string % { :p => player, :o => opponent }
    opponent.skips += player.discard.skips
    # Redemption tokens
    if opponent.discard
      if opponent.discard.name == 'insurance'
        say p_health(opponent)
        say opponent.discard.string % { :p => opponent }
        opponent.health = opponent.discard.health
      end
    end
    # Announce health
    if player.discard.type == :support or player.discard.name == 'heal steal'
      if player.discard.name == 'heal steal'
        if temp_deck.length > 0
          s = if temp_deck.length > 1 then 's' else '' end
          say "#{player} stole #{temp_deck.length} heal card#{s}!"
        end
      end
      say p_health(player)
    elsif player.discard.name != 'garbage man' and player.discard.name != 'flipper'
      say p_health(opponent)
      check_health(opponent)
    end
    player.discard = nil
  end

  def do_counter(player, opponent, c)
    unless c[0].type == :counter
      say "Play a counter or pass."
      return
    end
    case c[0].name
    when 'grab'
      if c[1].nil?
        notify player, "Play an attack when grabbing."
        return
      elsif c[1].type == :counter or c[1].type == :power
        notify player, "You can't play a #{c[1].type} card when grabbing."
        return
      elsif c[1].name == 'white wedding'
        unless player.health == 1
          notify player, "You can only use that card with 1 health."
          return
        end
      elsif c[1].name == 'garbage man'
        player.garbage = c[2..-1]
      end
      do_move(opponent, player, wait=false)
      return if player.health < 1 # In case player dies mid-grab.
      player.discard = c[1]
      opponent.grabbed = true
      say c[0].string % { :p => player, :o => opponent }
      @discard |= [ c[0], c[1] ]
      player.delete_cards([c[0], c[1]])
      notify opponent, p_cards(opponent)
      return
    when 'dodge'
      if player.grabbed
        notify player, "You can't dodge. #{opponent.user} already " +
                       "grabbed you! Got any other counters?"
        return
      end
      n = 0
      until players[n] == player
        n += 1
      end
      n = next_turn(n)
      @discard << c[0]
      player.delete_cards(c[0])
      if players[n] == opponent
        say "#{player} dodged and nullified " +
            "#{opponent.user}'s #{opponent.discard}!"
        increment_turn
      else
        say "#{player} jumps out of the way and passes " +
            "#{opponent.user}'s attack onto #{players[n]}!"
        @attacked = players[n]
      end
      return
    when 'block'
      unless opponent.discard.type == :unstoppable
        @discard << c[0]
        player.delete_cards(c[0])
        say c[0].string % { :p => player, :o => opponent,
                            :c => opponent.discard }
        increment_turn
        return
      end
    when 'insurance'
      bees = if player.bees then -1 else 0 end
      ensuing_health = player.health + opponent.discard.health + bees
      unless ensuing_health < 1 and not player.deflector
        notify player, "You can only use your insurance " +
                       "as a last resort before death."
        return
      end
    end
    # Play counter
    @discard << c[0]
    player.delete_cards(c[0])
    player.discard = c[0]
    do_move(opponent, player, wait=false)
    increment_turn
  end

  def increment_turn
    return if players.length < 2
    unless attacked.nil?
      attacked.discard = nil
      attacked.grabbed = false
      @attacked = nil
    end
    players[turn].discard = nil
    players[turn].grabbed = false
    if players[turn].multiball
      players[turn].multiball = false
    else
      @turn = next_turn
    end
    # Deal new player
    player = players[turn]
    if player.cards.length < 5
      n = 5 - player.cards.length
      deal(player, n)
    end
    if player.bees
      player.health -= 1
      say "#{player} is stung by THE BEES."
      say p_health(player)
      check_health(player)
    end
    if player.skips > 0
      say "#{player} misses a turn."
      player.skips -= 1
      increment_turn
    else 
      say p_turn
      notify player, p_cards(player)
    end
  end

  def next_turn(num=turn)
    if reverse
      if num == 0
        n = players.length - 1
      else
        n = num - 1
      end
    else
      if num >= players.length - 1
        n = 0
      else
        n = num + 1
      end
    end
    return n
  end

  def end_game
    p = players[0]
    if p.health >= MAX_HP
      p.damage += p.health
      say "#{p} wins! Health bonus: +#{p.health}, Damage done: #{p.damage}"
    else
      say "#{p} wins! Damage done: #{p.damage}"
    end
    update_chan_stats(p.damage)
    update_user_stats(p)
    @plugin.remove_game(channel)
  end

  def update_chan_stats(damage)
    if @registry.has_key? channel.name
      @registry[channel.name] = [ @registry[channel.name][0] + 1, 
                                  @registry[channel.name][1] + damage,
                                  @registry[channel.name][2]
                                ]
    else
      @registry[channel.name] = [ 1, damage, {} ]
    end
  end

  def update_user_stats(player, win=1)
    c = channel.name
    nick = player.user.to_s
    p = player.user.downcase
    unless @registry.has_key? c
      @registry[channel.name] = [ 0, 0, {} ]
    end
    # Player's channel damage:
    player_hash = @registry[c][2]
    if player_hash.has_key? p
      player_hash[p] = { :nick => nick,
                         :wins => player_hash[p][:wins] + win,
                         :games => player_hash[p][:games] + 1,
                         :damage => player_hash[p][:damage] + player.damage
                       }
    else
      player_hash[p] = { :nick => nick,
                         :wins => win,
                         :games => 1,
                         :damage => player.damage
                       }
    end
    @registry[c] = [ @registry[c][0], @registry[c][1], player_hash ]
    # Player's network-wide damage:
    if @registry.has_key? p
      @registry[p] = { :nick => nick,
                       :wins => @registry[p][:wins] + win,
                       :games => @registry[p][:games] + 1,
                       :damage => @registry[p][:damage] + player.damage
                     }
    else
      @registry[p] = player_hash[p]
    end
  end

end


class BrawlPlugin < Plugin

  BRAWL = Bold + "Brawl!" + Bold
  MAX_HP = Brawl::MAX_HP

  attr :games

  def initialize
    super
    @games = {}
  end

  def help(plugin, topic='')
    c = NormalText
    b = Bold + Irc.color(:brown,:black)
    o = Bold + Irc.color(:olive,:black)
    t = Bold + Irc.color(:teal,:black)
    w = Bold + Irc.color(:white,:black)
    y = Bold + Irc.color(:yellow,:black)
    prefix = @bot.config['core.address_prefix'].first
    case topic.downcase
    when 'attacking'
      "When it's a player's turn they can play an #{y}Attack#{c}/" +
      "#{o}Unstoppable#{c} card to attack a player, or a #{t}Support#{c} " +
      "card (like pills if you wish to heal). Instead of attacking " +
      "when it's their turn, a player can discard cards they " +
      "don't want. If they have no playable cards, they must discard."
    when 'attacked'
      "#{w}Counter#{c} cards are played by the person being attacked to " +
      "negate or mitigate the damage they receive. If they counter " +
      "an attack with a Grab they must also play an Attack, Support, " +
      "or Unstoppable card face down along with it. If they have " +
      "no counter, they can pass and accept fate."
    when /cards?/
      "Players have 5 cards in their hand. There are 5 types of cards: " +
      "#{y}Attack Cards#{c} are played on your turn against other players. " +
      "#{o}Unstoppable Cards#{c} are as well, but cannot be blocked by the " +
      "opponent. #{t}Support Cards#{c} heal you. #{w}Counter Cards#{c} " +
      "counter attacks against you. #{b}Power Cards#{c} either" +
      "affect all players or a random player. They do not consume " +
      "a turn. Play these cards at the beginning of anyone's turn. " +
      "Use #{prefix}help #{plugin} <card> for card-specific info."
    when /commands?/
      "c/cards - show cards and health, d/discard - discard, " +
      "o/order - show playing order, pa/pass - pass, p/play - " +
      "play cards, s/score - show score, t/turn - current turn"
    when 'grabbing'
      "Although a Counter card, Grab can be played on a player's turn. " +
      "They must play their intended attack/unstoppable/support card " +
      "underneath the grab. The attacked player doesn't get to see " +
      "what card is attacking them until they respond with a counter " +
      "or pass. Players can't dodge when being grabbed. If the card " +
      "that grabbed them turns out to be an unstoppable " +
      "attack, their counter card is wasted."
    when /objectives?/
      "Every player has #{MAX_HP} health. Play cards against an " +
      "opponent to take away their health. Be the last player standing."
    when /stat(s?|istics?)/, /tops?/
      "#{prefix}#{plugin} stats nick (network-wide stats) - " +
      "#{prefix}#{plugin} stats #channel nick (channel-specific stats) - " +
      "#{prefix}#{plugin} top (top 5 players)"
    when 'block'
      "#{w}Block#{c} - Block a basic attack card when played against you. " +
      "Can be used against a grab to nullify the grab's proceeding attack."
    when 'dodge'
      "#{w}Dodge#{c} - Similar to a block, but the attack " +
      "is passed onto the next player. Cannot counter a grab."
    when 'grab'
      "#{w}Grab#{c} - Play this as a counter so you can attack back. " +
      "This cannot be dodged. Also note this can be played before " +
      "an attack to disguise your type of attack."
    when 'pillow'
      "#{w}Pillow#{c} - Reduces opponent's attack by 2 points."
    when 'insurance'
      "#{w}Insurance#{c} - Can only be used against a " +
      "blockable killing blow. Resets you to 5 health points."
    when 'humiliation'
      "#{y}Humiliation#{c} (-0) - This does no damage, " +
      "but your opponent must spend 2 turns in therapy."
    when /eye( ?poke)?/, 'poke'
      "#{y}Eye Poke#{c} (-2) - Opponent loses 2 health and is blinded for 1 turn."
    when /gut( ?punch)?/, 'punch'
      "#{y}Gutpunch#{c} (-2) - Basic attack."
    when /nose ?(bleed)?/
      "#{y}Nose Bleed#{c} (-3) - Opponent loses a turn to clean it up."
    when /neck( ?punch)?/
      "#{y}Neck Punch#{c} (-3) - Slightly more powerful " +
      "attack directed at the neck of your opponent."
    when /kick( ?ball)?/
      "#{y}Kickball#{c} (-4) - Major damage due to a swift kick " +
      "in the balls. Can be used on players that don't have balls."
    when /upper ?cut/
      "#{y}Uppercut#{c} (-5) - Ultimate damage."
    when 'trip'
      "#{o}Trip#{c} (-0) - Trip your opponent when they least suspect it, causing them to lose 1 turn."
    when /trout( ?slap)?/, 'slap'
      "#{o}Trout Slap#{c} (-1) - An mIRC-inspired attack. Slap your opponent with a trout."
    when /(a ?)gun/
      "#{o}A Gun#{c} (-2) - Can't dodge a gun. Simple as that."
    when /tire( ?iron)?/, 'iron'
      "#{o}Tire Iron#{c} (-3) - Beat your defenseless opponent senseless."
    when /flippers?/
      "#{o}Flipper#{c} (-0) - Opponent drops " +
      "all their cards and draws new ones."
    when /garbage( ?man)?/, 'man'
      "#{o}Garbage Man#{c} (-0) - Give a player all your cards " +
      "you don't want. The opponent won't get any new cards until " +
      "they manage to get their hand below 5 cards again."
    when /heal( ?steal)?/, 'steal'
      "#{o}Heal Steal#{c} (+0 to +#{MAX_HP-1}) - Steal all of an " +
      "opponent's soup and pills, if he has any, and use them on yourself."
    when /slot( ?machine)?/, 'machine'
      "#{o}Slot Machine#{c} (-0 to -9) - Spits out three " +
      "random attack values from 0 to 3. Attack does the " +
      "sum of the three numbers. Can't be blocked."
    when 'soup'
      "#{t}Soup#{c} (+1) - Take a sip. Relax. Gain health."
    when 'pills'
      "#{t}Pills#{c} (+2) - Heal yourself by 2 points, up to a " +
      "maximum of #{MAX_HP}. Can be played instead of attacking."
    when 'armor'
      "#{t}Armor#{c} (+5) - Adds 5 extra points to your " +
      "health on top of your maximum. Your main HP will " +
      "be protected until the armor is depleted."
    when /s(e|u)rg(e|u)ry/
        "#{t}Surgery#{c} (#{MAX_HP-1}) - Used only when " +
        "a player has 1 health. Resets health to #{MAX_HP}."
    when /deflect(ed|or|ing|s)?/
      "#{b}Deflector#{c} - Next attack played " +
      "against you hurts a random player that isn't you."
    when /f+/
      "#{b}FFFFFF#{c} - Inflicts 6 damage " +
      "to a random player (including you)."
    when /it\'?s(( ?getting)? ?windy)?/, 'getting', 'windy'
      "#{b}It's Getting Windy#{c} - All players choose " +
      "a random card from the player previous to them."
    when /multi-?( ?ball)?/, 'ball'
      "#{b}Multi-ball#{c} - Take an extra turn after your turn."
    when /shifty( ?business)?/, 'business'
      "#{b}Shifty Business#{c} - Swap hand cards with a random player."
    when /the( ?bee*s)?/, 'bee*s'
      "#{b}THE BEES#{c} - Random player is stung by bees and " +
      "must do their best Nicholas Cage impression. Also, " +
      "-1 health every turn until player uses a support card."
    when 'whirlwind'
      "#{b}Whirlwind#{c} - Every player shifts the cards " +
      "in their hands over to the player beside them."
    when 'reverse'
      "#{b}Reverse#{c} - REVERSE playing order."
    else
      "Brawl help topics: commands, objective, stats, " +
      "#{Bold}Rules:#{Bold} attacking, attacked, cards, grabbing"
    end
  end

  Config.register Config::IntegerValue.new('brawl.countdown',
    :default => 20, :validate => Proc.new{|v| v > 2},
    :desc => "Number of seconds before starting a game of Brawl.")

  def message(m)
    return unless @games.key?(m.channel) or m.plugin
    g = @games[m.channel]
    msg = m.message.downcase
    p = g.get_player(m.source.nick)
    case msg
    when /^(jo?|join)\b/
      g.add_player(m.source)
    when /^(ca?|cards?)\b/
      if p.nil?
        retort = 
          [ "Don't make me take you and this" +
            "#{BRAWL} outside, #{m.source.nick}.",
            "Sorry, #{m.source.nick}, this is between me and the guys.",
            "What do you need, #{m.source.nick}?"
          ]
        m.reply retort.sample
      end
      @bot.notice m.sourcenick, g.p_cards(p)
      m.reply g.p_health
    when /^(di?|discard)\b/
      return unless g.has_turn?(m.source)
      g.discard(msg)
    when /^drop/
      return if p.nil?
      unless g.turn.nil?
        g.drop_player(p)
      end
    when /^(pa|pass)\b/
      return unless g.attacked
      if g.attacked == p or p.grabbed
        g.pass(p)
      elsif g.has_turn?(m.source)
        g.pass(p)
      end
    when /^(pl?|play)\b/
      return if p.nil?
      return if g.turn.nil?
      request = msg.split(' ')
      return if request.length < 2
      request.delete_at(0) # => [ "frank", "2", "4" ]
      if g.has_turn?(m.source)
        g.play_move(request)
      else
        g.play_counter(p, request)
      end
    when /^(od?|order)\b/
      m.reply g.p_order unless g.turn.nil?
    when /^(sc?|scores?)\b/
      m.reply g.p_damage unless g.turn.nil?
    when /^(tu?|turn)\b/
      m.reply g.p_turn unless g.turn.nil?
    end
  end

  def create_game(m, plugin)
    if @games.key?(m.channel)
      user = @games[m.channel].manager
      if m.source == user
        m.reply "...you already started a #{BRAWL}"
        return
      else
        m.reply "#{user} already started a #{BRAWL}"
        return
      end
    end
    @games[m.channel] = Brawl.new(self, m.channel, self.registry, m.source)
  end

  # Called from within the game.
  def remove_game(channel)
    @games.delete(channel)
  end

  def stop_game(m, plugin)
    @games.delete(m.channel)
    m.reply "#{BRAWL} stopped."
  end

  def show_stats(m, params)
    if params[:x].nil?
      x = m.source.nick
    elsif params[:x] == false
      x = m.channel.name.to_s
    else
      x = params[:x].to_s
    end
    xd = x.downcase
    unless @registry.has_key? xd
      if x =~ /^#/
        m.reply "No one has played #{BRAWL} in #{x}."
      elsif x == m.source.nick
        m.reply "You haven't played #{BRAWL}"
      else
        m.reply "#{x} hasn't played #{BRAWL}"
      end
      return
    end
    if params[:y].nil?
      if x =~ /^#/
        m.reply "#{Bold}#{x}#{Bold} -- " +
                "(games: #{@registry[xd][0]}, " + 
                "total damage: #{@registry[xd][1]})"
        # Make an array of the channel's top players.
        a = @registry[xd][2].dup
        a = a.to_a.each { |e| e.slice!(0) }
        a.flatten!
        a.sort! { |x,y| y[:damage] <=> x[:damage] }
        top_players = a[0..4]
        n = 1
        top_players.each do |k|
          m.reply "#{Bold}#{n}. #{k[:nick]}#{Bold} - #{k[:damage]} dmg " +
                  "(#{k[:wins]}/#{k[:games]} games won)"
          n += 1
          end
        return
      else
        m.reply "#{Bold}#{@registry[xd][:nick]}#{Bold} -- " +
                "Wins: #{@registry[xd][:wins]}, " +
                "games: #{@registry[xd][:games]}, " +
                "damage: #{@registry[xd][:damage]}"
        return
      end
    end
    y = params[:y].to_s.downcase
    unless @registry[x][2].has_key? y
      "They haven't played a game in this channel, #{m.source.nick}"
      return
    end
    m.reply "#{Bold}#{@registry[x][2][y][:nick]}#{Bold} (in #{x}) -- " +
            "Wins: #{@registry[x][2][y][:wins]}, " +
            "games: #{@registry[x][2][y][:games]}, " +
            "damage: #{@registry[x][2][y][:damage]}"
  end

end


plugin = BrawlPlugin.new

plugin.map 'brawl cancel',
  :private => false, :action => :stop_game
plugin.map 'brawl end',
  :private => false, :action => :stop_game
plugin.map 'brawl stat[s] [:x [:y]]',
  :action => :show_stats
plugin.map 'brawl stop',
  :private => false, :action => :stop_game
plugin.map 'brawl top',
  :private => false, :action => :show_stats, :defaults => { :x => false }
plugin.map 'brawl',
  :private => false, :action => :create_game
