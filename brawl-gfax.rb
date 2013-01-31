# coding: UTF-8
#
# :title: Junkyard
#
# Author:: Lite <degradinglight@gmail.com>
# Copyright:: (C) 2012 gfax.ch
# License:: GPL
# Version:: 2013-01-30
#

class Junkyard

  TITLE = Bold + "Brawl!" + Bold
  MAX_HP = 10
  COLORS = { :attack => Bold + Irc.color(:lightgray,:black),
             :counter => Bold + Irc.color(:green,:black),
             :power => Bold + Irc.color(:brown,:black),
             :support => Bold + Irc.color(:teal,:black),
             :unstoppable => Bold + Irc.color(:yellow,:black),
           }

  class Card

    attr_reader :id, :name, :health, :skips, :string, :type

    def initialize(id)
      @id = id.downcase
      case @id
      when :block
        @type = :counter
        @string = "%{p} blocks %{o}'s %{c}."
      when :dodge
        @type = :counter
        @string = "%{p} dodges %{o}'s %{c}."
      when :grab
        @type = :counter
        @string = "%{p} grabs %{o}. Respond or pass, %{o}."
      when :pillow
        @name = 'Wet Pillow'
        @type = :counter
        @health = 2
        @string = "The wet pillow descends from heaven to shield %{p}."
      when :insurance
        @name = 'Credit Feed'
        @type = :counter
        @health = 5
        @string = "%{p} feeds me some credits and " +
                  "is restored to #{@health} health!"
      when :wrench
        @name = 'Roach Approach'
        @type = :attack
        @string = "%{p} psychologically devastates %{o} with a Roach approach."
        @skips = 2
      when :eye_poke
        @name = 'Broken Heart'
        @type = :attack
        @health = -2
        @string = "%{o} watches Jurassic Bark. :'("
        @skips = 1
      when :gutpunch
        @type = :attack
        @health = -2
        @string = "A wild TODD appears and gutpunches %{o}."
      when :nose_bleed
        @name = 'Chihiro'
        @type = :attack
        @health = -3
        @string = "Chihiro claws %{o} in an excited rage. She pees a little."
        @skips = 1
      when :neck_punch
        @type = :attack
        @health = -3
        @string = "%{p} delivers %{o} a punch in the neck."
      when :kickball
        @type = :attack
        @health = -4
        innuendo = [ 'toolbox', 'junk', 'private belongings', 
                     'particle accelerator', 'anodes', 'anchors',
                     'Jimmy Deans', 'coat rack', 'balls'
                   ]
        @string = "%{p} delivers %{o}'s #{innuendo.sample} a swift kick."
      when :uppercut
        @name = 'Touch'
        @type = :attack
        @health = -5
        @string = "%{o} receives a touch from LordKaT."
      when :slot_machine
        @type = :attack
        @string = "Next time stick to the pachinkos, %{o}."
      when :trip
        @name = 'Looke Out'
        @type = :unstoppable
        @string = "%{o} catches word of Looke coming " +
                  "to town and decides to wait around."
        @skips = 1
      when :trout_slap
        @name = 'Danger Zone'
        @type = :unstoppable
        @health = -1
        @string = "%{p} leaves Danger Zone on repeat and " +
                  "forever ruins %{o}'s last.fm profile."
      when :a_gun
        @type = :unstoppable
        @health = -2
        @string = "%{p} shoots %{o} in the FACE."
      when :tire_iron
        @name = 'Rocket Lawn Chair'
        @type = :unstoppable
        @health = -3
        @string = "%{p} blows up %{o} with a Rocket Lawn Chair."
      when :flipper
        @type = :unstoppable
        case rand(2)
        when 0
          @string = "%{p} flips over the table, knocking " +
                    "all the cards out of %{o}'s hand."
        when 1
          @string = "%{p} violently SLAPS the cards " +
                    "out of %{o}'s hand for no raisin."
        end
      when :garbage_man
        @type = :unstoppable
        @string = "%{p} dumps a bunch of garbage cards on %{o}."
      when :meal_steal
        @name = 'Heal Steal'
        @type = :unstoppable
        @string = "%{p} rummages through %{o}'s hand for DDP and peelz."
      when :soup
        @name = 'DDP'
        @type = :support
        @health = 1
        @string = "%{p} takes a sip of DDP, relaxes."
      when :sub
        @name = 'Peelz'
        @type = :support
        @health = 2
        @string = "%{p} peel'd up!"
      when :armor
        @type = :support
        @health = 5
        @string = "%{p} buckles on some armor."
      when :surgery
        @name = 'White Wedding'
        @type = :support
        @health = MAX_HP - 1
        @string = "It's a nice day to... START AGAIN!!! HEALTH RESTORED!!!"
      when :deflector
        @type = :power
        @string = "%{p} raises a deflector shield!"
      when :avalanche
        @name = 'FFFFFF'
        @type = :power
        @health = -6
        @string = "%{p} randomly inflicts 6 damage on %{o}. What a dick!"
      when :earthquake
        @name = "Fireball"
        @type = :power
        @health = -1
        @string = "%{p} drops a fireball on everyone."
      when :windy
        @name = 'It\'s Getting Windy'
        @type = :power
        @string = "%{p} turns up the ceiling fan too high and blows up " +
                  "a gust! Every player passes a random card forward."
      when :toolbox
        @name = 'Loot Bag'
        @type = :power
        @string = "%{p} loots %{n} cards from the deck."
      when :multiball
        @name = 'Multi-ball'
        @type = :power
        @string = "%{p} lites multi-ball."
      when :shifty_business
        @type = :power
        @string = "%{p} swaps hands with %{o}!"
      when :the_bees
        @type = :power
        @string = "%{p} drops the bee cage on %{o}'s head..."
      when :whirlwind
        @type = :power
        @string = "FEEL THE POWER OF THE WIND"
      when :reverse
        @name = 'You\'re Your Grandfather'
        @type = :power
        @string = "%{p} reverses the table!"
      else
        raise 'Invalid card name.'
        return
      end
      @name = @id.to_s.split('_').each{|w| w.capitalize!}.join(' ') if @name.nil?
      @health = 0 if @health.nil?
      @skips = 0 if @skips.nil?
    end

    def to_s
      color = COLORS[type]
      hs = if health.zero? then ''
           elsif health < 0 then Irc.color(:red) + health.to_s
           else Irc.color(:blue) + '+' + health.to_s
           end
      ss = if skips.zero?
             ''
           elsif hs == ''
             Irc.color(:purple) + skips.to_s
           else 
             Irc.color(:white) + '/' +
             Irc.color(:purple) + skips.to_s
           end
      color + " #{name} #{hs}#{ss}" + NormalText
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
        n += 1 until c[n].id == r.id
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


  attr_reader :attacked, :channel, :deck, :discard, :dropouts,
              :manager, :players, :registry, :slots, :started

  def initialize(plugin, channel, registry, manager)
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
    @slots = []
    @started = nil    # if game started
    create_deck
    add_player(manager)
  end

  def say(msg, opts={})
    @bot.say channel, msg, opts
  end

  def notify(player, msg, opts={})
    unless player.user == @bot.nick
      @bot.notice player.user, msg, opts
    end
  end

  def create_deck
    10.times do
      @deck << Card.new(:gutpunch)
      @deck << Card.new(:neck_punch)
    end
    8.times do
      @deck << Card.new(:grab)
    end
    7.times do
      @deck << Card.new(:kickball)
      @deck << Card.new(:sub)
    end
    6.times do
      @deck << Card.new(:dodge)
    end
    5.times do
      @deck << Card.new(:block)
      @deck << Card.new(:uppercut)
    end
    3.times do
      @deck << Card.new(:eye_poke)
      @deck << Card.new(:soup)
      @deck << Card.new(:pillow)
    end
    2.times do
      @deck << Card.new(:a_gun)
      @deck << Card.new(:trout_slap)
      @deck << Card.new(:nose_bleed)
      @deck << Card.new(:insurance)
      @deck << Card.new(:trip)
      @deck << Card.new(:meal_steal)
      @deck << Card.new(:wrench)
      @deck << Card.new(:slot_machine)
      @deck << Card.new(:surgery)
    end
    1.times do
      @deck << Card.new(:armor)
      @deck << Card.new(:avalanche)
      @deck << Card.new(:deflector)
      @deck << Card.new(:earthquake)
      @deck << Card.new(:flipper)
      @deck << Card.new(:garbage_man)
      @deck << Card.new(:toolbox)
      @deck << Card.new(:multiball)
      @deck << Card.new(:tire_iron)
      @deck << Card.new(:shifty_business)
      @deck << Card.new(:the_bees)
      @deck << Card.new(:whirlwind)
      @deck << Card.new(:windy)
      @deck << Card.new(:reverse)
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
    unless started.nil?
      notify player, "#{Bold}You drew:#{Bold} #{cards.join(', ')}"
    end
    player.cards |= cards
    player.sort_cards
  end

  def start_game
    @players = @players.shuffle#!
    @started = true
    say p_turn
    players.each do |p|
      notify p, p_cards(p)
    end
    bot_move
  end

  def add_player(user)
    if p = get_player(user)
      if p == @bot.nick
        say "I'm already in the game, moron."
      else
        say "You're already in the game, #{p}."
      end
      return
    end
    @dropouts.each do |dp|
      if dp.user == user
        if user == @bot.nick
          say "I was dropped from the game, moron."
        else
          say "You were dropped from the game, #{dp}. You can't get back in."
        end
        return
      end
    end
    p = Player.new(user)
    @players << p
    if user == manager
      say "#{p} starts a #{TITLE} Type 'j' to join."
    else
      say "#{p} joins the #{TITLE}"
    end
    deal(p, 5)
    if players.length == 2
      countdown = @bot.config['junkyard.countdown']
      @bot.timer.add_once(countdown) { start_game }
      say "Game will start in #{Bold}#{countdown}#{Bold} seconds."
    end
  end

  def drop_player(player, killed=false)
    if attacked
      attacked.discard = nil
      attacked.grabbed = nil
    end
    if player == players.first
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
               "%{p} paid the ultimate price.",
               "Fatal racing crash. Car flipped about 2,457 times. " +
               "No survivors. %{p} was killed on impact. R.I.P."
             ]
      bot_died = [ "has seen better days",
                   "lived a better life than all you fools.",
                   "gives his last regards to Chanserv.",
                   "goes to meet that ol' pi in the sky.",
                   "wills his pancake collection to #{players.first.user}",
                   "lost the Brawl! ...but wins the war.",
                   "is invincible!",
                   "died the most honorable death.",
                   "can't feel his legs, but only because he has none."
                 ]
      if player.user == @bot.nick
        @bot.action channel, bot_died.sample
      else
        say died.sample % { :p => player }
      end
    else
      say "#{player} has been removed from the game."
    end
    @discard |= player.cards
    @discard << player.deflector if player.deflector
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
    return false unless started
    return true if src == players.first.user
    return false
  end

  def bee_recover(player)
    if player.bees
      say "#{player} recovers from bee allergies."
      player.bees = false
    end
  end

  def valid_insurance?(player, opponent)
    bees = if player.bees then -1 else 0 end
    ensuing_health = player.health + opponent.discard.health + bees
    if opponent.discard.id == :slot_machine
      slots.each { |n| ensuing_health -= n }
    end
    return true if ensuing_health < 1 and not player.deflector
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
    string = "Roster -"
    players.each do |p|
      string << "- #{p}: #{p.health} "
    end
    return string
  end

  def p_order
    string = p_turn
    string << " "
    string << p_health
    return string
  end

  def p_turn
    return "It's #{players.first}'s turn."
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

  def discard(a)
    player = players.first
    if attacked
      say "You can only discard at the start of your turn."
      return
    end
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
      if player == players.first
        do_move(attacked, players.first, wait=false)
      end
    end
    if players.first.discard
      if player == attacked
        do_move(players.first, attacked, wait=false)
      end
    end
    increment_turn
  end

  def bot_inventory(player)
    # Make an inventory of what the bot has.
    c_hash = { :support => [], :surgery => [],
               :counter => [], :dodge => [], :grab => [], :insurance => [],
               :unstoppable => [], :attack => [], :power => []
             }
    player.cards.each do |c|
      case c.id
      when :dodge, :grab, :insurance, :surgery
        c_hash[c.id] << c
      else
        c_hash[c.type] << c
        c_hash[c.type].sort! {|x,y| x.health  <=> y.health }
        c_hash[c.type].reverse! if c.type == :support
      end
    end
    c_hash
  end

  def bot_move
    p = players.first
    return unless p.user == @bot.nick
    a = [] # array to pass to play_move
    # For now, just make the bot pick on a random player.
    n = rand(players.length)
    n = rand(players.length) while players[n] == p
    a << players[n].user.to_s
    # Pick the best card to play.
    c_hash = bot_inventory(p)
    card = if p.health == 1 and c_hash[:surgery].any?
             c_hash[:surgery].first
           elsif p.bees and c_hash[:support].any?
             c_hash[:support].first
           elsif c_hash[:grab].any? and c_hash[:unstoppable].any? and c_hash[:attack].any?
             c_hash[:grab].any?
           elsif c_hash[:unstoppable].any?
             c_hash[:unstoppable].first
           elsif c_hash[:attack].any?
             c_hash[:attack].first
           elsif p.health < (MAX_HP - 1) and c_hash[:support].any?
             c_hash[:support].first
           elsif c_hash[:power].any?
             c_hash[:power].first
           else nil
           end
    # Find out which card in the deck this is,
    # if we have indeed found a suitable card.
    unless card.nil?
      n = 1
      p.cards.each do |c|
        break if c.id == card.id
        n += 1
      end
      a << n
      n2 = rand(p.cards.length)
      if card.id == :garbage_man and p.cards.length > 1
        # Throw a random card at the player
        # just for the heck of it!
        n2 = rand(p.cards.length) while n == n2
        a << n2
      elsif card.id == :grab
        until p.cards[n2].type == :unstoppable or p.cards[n2].type == :attack
          n2 = rand(p.cards.length)
        end
        a << n2
      end
    end
    # Play the card or otherwise discard.
    if a.length > 1
      say "p #{a.join(' ')}"
      play_move(a)
    else
      a = Array.new(p.cards.length) { |i| i + 1 }
      # Don't discard the first card in the hand if we can help it.
      a.shift unless a.length < 2
      say "d #{a.join(' ')}"
      discard(a)
    end
    @bot.timer.add_once(2) { bot_move } if card.type == :power
  end

  def bot_counter
    p = nil
    players.each do |player|
      p = player if player.user == @bot.nick
    end
    # Return if the bot's not playing or it's not his turn.
    return if p.nil?
    return if p.discard
    return unless p == attacked or p.grabbed
    o = if p.user == players.first.user
          attacked
        else
          players.first
        end
    # Pick the best card to play.
    a = [] # hash of cards to play
    c_hash = bot_inventory(p)
      say "#{p.cards.join(', ')}"
    if valid_insurance?(p, o) and c_hash[:insurance].any?
      say 'c2a'
      card = c_hash[:insurance].first
    elsif p.bees and c_hash[:grab].any? and c_hash[:support].any?
      say 'c2b'
      card = c_hash[:grab].first
      card2 = c_hash[:support].first
    elsif not p.grabbed and c_hash[:dodge].any?
      say 'c2c'
      card = c_hash[:dodge].first
    elsif p.health <= (MAX_HP/2) and c_hash[:grab].any? and c_hash[:support].any?
      say 'c2d'
      card = c_hash[:grab].first
      card2 = c_hash[:support].first
    elsif p.health <= (MAX_HP/2) and c_hash[:counter].any?
      say 'c2e'
      card = c_hash[:counter].first
    elsif c_hash[:counter].any?
      say 'c2f'
      card = if o.discard.health <= -3
               c_hash[:counter].first
             else
               case rand(2)
               when 0 then c_hash[:counter].first
               else nil
               end
             end
    else
      say 'c2g'
      card = nil
    end
    # Find out which card in the deck this is,
    # if we have indeed found a suitable card.
    unless card.nil?
      n = 1
      p.cards.each do |c|
        break if c.id == card.id
        n += 1
      end
      a << n
      if card.id == :grab
        n = 1
        p.cards.each do |c|
          break if c.id == card2.id
          n += 1
        end
        a << n
      end
    end
    # Play the card or otherwise discard.
    if a.length > 0
      n2 = '' if n2.nil?
      say "p #{n} #{n2}"
      play_counter(p, a)
    else
      say "pa"
      pass(p)
    end
  end

  def play_move(a)
    player = players.first
    # Figure out which player is attacking, if anybody.
    if players.length == 2
      # If just two players are playing, the opponent
      # is assumed to be the player not attacking.
      a.delete_at(0) if get_player(a[0])
      opponent = players[1]
    else
      if attacked
        opponent = attacked
      else
        # Don't really need an opponent if power/support card.
        temp_card = a[0].to_i - 1
        if temp_card.between?(0, player.cards.length-1)
          temp_card = player.cards[temp_card]
          if temp_card.type == :power or temp_card.type == :support
            opponent = players[1]
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
      if c[0].id == :grab
        if c[1].nil?
          notify player, "Play an attack when grabbing."
          return
        end
        if c[1].type == :counter or c[1].type == :power
          notify player, "You can't play a #{c[1].type} card when grabbing."
          return
        end
        if c[1].id == :surgery
          unless player.health == 1
            notify player, "You can only use that card with 1 health."
            return
          end
        end
        @discard |= [ c[0], c[1] ]
        player.discard = c[1]
        do_slots(player)
        if player.discard.id == :garbage_man
          player.garbage = c[2..-1]
        end
        player.delete_cards([c[0], c[1]])
        @attacked = opponent
        opponent.grabbed = true
        say c[0].string % { :p => player, :o => opponent }
        notify opponent, p_cards(opponent)
        @bot.timer.add_once(2) { bot_counter }
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
    if c[0].id == :surgery
      unless player.health == 1
        notify player, "You can only use that card with 1 health."
        return
      end
    end
    @discard << c[0]
    player.discard = c[0]
    if player.discard.id == :garbage_man
      player.garbage = c[1..-1]
    end
    player.delete_cards(c[0])
    # Deflector, (by our interpretation of the rules,) automatically
    # pushes the attack onto a person without giving them a chance
    # to respond, therefore we execute the attack and increment_turn.
    deflecting = if opponent.deflector then true else false end
    do_move(player, opponent)
    if opponent.grabbed == false and deflecting
      increment_turn 
    elsif c[0].type == :support or c[0].type == :unstoppable
      increment_turn
    end
  end

  def play_counter(player, a)
    c = []
    a.uniq!
    a.delete_at(0) if get_player(a[0])
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
    opponent = players.first
    do_counter(player, opponent, c)
  end

  def do_power(player, card)
    unless attacked.nil?
      say "You cannot play power cards in the middle of an attack, #{player}."
      return
    end
    # Deflector isn't discarded until it is used up.
    @discard << card unless card.id == :deflector
    player.delete_cards(card)
    case card.id
    when :deflector
      player.deflector = card
      say card.string % { :p => player }
    when :avalanche
      victim = players[rand(players.length)]
      victim.health += card.health
      player.damage += card.health.abs
      say card.string % { :p => player, :o => victim }
      say p_health(victim)
      check_health(victim)
    when :earthquake
      say card.string % { :p => player }
      players.each do |p|
        p.health += card.health
        player.damage += card.health.abs
      end
      say p_health
      check_health
    when :windy
      say card.string % { :p => player }
      temp_deck = []
      players.each do |p|
        c = p.cards[rand(p.cards.length)]
        temp_deck << c
        p.delete_cards(c)
      end
      temp_deck << temp_deck.shift
      n = 0
      temp_deck.each do |e|
        @players[n].cards << e
        n += 1
      end
    when :toolbox
      n = if player.cards.length > 8 then 0 else 8 - player.cards.length end
      deal(player, n)
      say card.string % { :p => player, :n => n }
    when :multiball
      player.multiball = true
      say card.string % { :p => player }
    when :shifty_business
      n = rand(players.length)
      while players[n] == player
        n = rand(players.length)
      end
      say card.string % { :p => player, :o => players[n] }
      player.cards, players[n].cards = players[n].cards, player.cards
      notify(player, p_cards(player)) unless player == players.first
    when :the_bees
      n = rand(players.length)
      players[n].bees = true
      say card.string % { :p => player, :o => players[n] }
    when :whirlwind
      temp_deck = []
      players.each do |p| 
        temp_deck << p.cards 
      end
      temp_deck << temp_deck.shift
      n = 0
      temp_deck.each do |h|
        @players[n].cards = h
        n += 1
      end
      say card.string % { :p => player }
      notify(player, p_cards(player)) unless player == players.first
    when :reverse
      say card.string % { :p => player }
      if players.length == 2 and player != players.first
        increment_turn
        return
      elsif players.length > 2
        @players = @players.reverse #!
        (players.length-1).times do
          @players << @player.shift
        end
      end
    end
    # In the rare event the current player has
    # no more cards, pass to the next player.
    increment_turn if players.first.cards.length == 0
    notify player, p_cards(player)
  end

  def do_slots(player)
    return if player.discard.nil?
    return unless player.discard.id == :slot_machine
    @slots.clear
    3.times do
      n = rand(4)
      @slots << n
    end
  end

  def do_move(player, opponent, wait=true)
    # Exercise deflectors.
    if opponent.deflector and player.discard.type != :support
      n = rand(players.length)
      while players[n] == opponent
        n = rand(players.length)
      end
      say "#{opponent} deflects #{player}'s attack!"
      do_slots(player) # In case a Slot Machine was deflected.
      @discard << opponent.deflector
      opponent.deflector = false
      @attacked = players[n]
      opponent = players[n]
      wait = false
    end
    case player.discard.type
    when :attack
      if wait
        do_slots(player) # Get some new slots while we wait.
        say "#{player} plays #{player.discard}. Respond or pass, #{opponent}."
        notify opponent, p_cards(opponent)
        @attacked = opponent 
        @bot.timer.add_once(2) { bot_counter }
        return
      end
      damage = 0
      # Determine amount of damage.
      if player.discard.id == :slot_machine
        string = "#{player} pulls #{opponent}'s lever..."
        slots.each do |slot|
          damage -= slot
          string << " #{slot}."
        end
        say string
      else
        damage += player.discard.health
      end
      # Adjust damage depending if opponent has a pillow.
      if opponent.discard
        if opponent.discard.id == :pillow
          damage += opponent.discard.health
          damage = 0 if damage > 0
          say opponent.discard.string % { :p => opponent, :o => player }
        end
      end
      opponent.health += damage
      player.damage += damage.abs
    when :support
      if player.discard.id == :armor
        player.health += player.discard.health
      else
        n = player.discard.health
        until player.health >= MAX_HP or n < 1
          player.health += 1
          n -= 1
        end
      end
      bee_recover(player)
    when :unstoppable
      if opponent.discard
        if opponent.discard.type == :counter
          say "#{opponent}'s #{opponent.discard} was thwarted!"
        end
      end
      case player.discard.id
      when :flipper
        until opponent.cards.length < 1
          temp_deck = opponent.cards
          temp_deck.each do |c|
            @discard << c
            opponent.delete_cards(c)
          end
        end
      when :garbage_man
        @discard |= player.garbage
        opponent.cards |= player.garbage
        player.delete_cards(player.garbage)
        player.garbage = nil
      when :meal_steal
        h, temp_deck = player.health, []
        opponent.cards.each do |e|
          if e.id == :soup or e.id == :sub
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
      if opponent.discard.id == :insurance
        say p_health(opponent)
        say opponent.discard.string % { :p => opponent }
        opponent.health = opponent.discard.health
      end
    end
    # Announce health
    if player.discard.type == :support or player.discard.id == :meal_steal
      if player.discard.id == :meal_steal
        if temp_deck.length > 0
          say "#{player} steals and chugs #{temp_deck.join(', ')}!!"
          bee_recover(player)
        end
      end
      say p_health(player)
    elsif player.discard.id != :garbage_man and player.discard.id != :flipper
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
    case c[0].id
    when :grab
      if c[1].nil?
        notify player, "Play an attack when grabbing."
        return
      elsif c[1].type == :counter or c[1].type == :power
        notify player, "You can't play a #{c[1].type} card when grabbing."
        return
      elsif c[1].id == :surgery
        unless player.health == 1
          notify player, "You can only use that card with 1 health."
          return
        end
      elsif c[1].id == :garbage_man
        player.garbage = c[2..-1]
      end
      do_move(opponent, player, wait=false)
      return if player.health < 1 # In case player dies mid-grab.
      player.discard = c[1]
      opponent.grabbed = true
      do_slots(player)
      say c[0].string % { :p => player, :o => opponent }
      @discard |= [ c[0], c[1] ]
      player.delete_cards([c[0], c[1]])
      notify opponent, p_cards(opponent)
      @bot.timer.add_once(2) { bot_counter }
      return
    when :dodge
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
        @bot.timer.add_once(2) { bot_counter } 
      end
      return
    when :block
      unless opponent.discard.type == :unstoppable
        @discard << c[0]
        player.delete_cards(c[0])
        say c[0].string % { :p => player, :o => opponent,
                            :c => opponent.discard }
        increment_turn
        return
      end
    when :insurance
      valid_insurance?(player, opponent)
      bees = if player.bees then -1 else 0 end
      ensuing_health = player.health + opponent.discard.health + bees
      unless ensuing_health < 1 and not player.deflector
        notify player, "You can only credit feed as " +
                       "a last resort before death."
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
    players.first.discard = nil
    players.first.grabbed = false
    if players.first.multiball
      players.first.multiball = false
    else
      @players << @players.shift
    end
    # Deal the new player some cards.
    player = players.first
    if player.cards.length < 5
      n = 5 - player.cards.length
      deal(player, n)
    end
    if player.bees
      player.health -= 1
      say "#{player} is stung by THE BEES."
      say p_health(player)
      check_health(player)
      # Turn will increment when they are dropped.
      return if player.health < 1
    end
    if player.skips > 0
      say "#{player} misses a turn."
      player.skips -= 1
      increment_turn
    else 
      say p_turn
      notify player, p_cards(player)
      @bot.timer.add_once(2) { bot_move }
    end
  end

  def next_turn(num=0)
    return 0 if num >= players.length - 1
    return num + 1
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


class JunkyardPlugin < Plugin

  TITLE = Junkyard::TITLE
  MAX_HP = Junkyard::MAX_HP

  attr :games

  def initialize
    super
    @games = {}
  end

  def help(plugin, topic='')
    prefix = @bot.config['core.address_prefix'].first
    cl = NormalText
    a = Junkyard::COLORS[:attack]
    c = Junkyard::COLORS[:counter]
    p = Junkyard::COLORS[:power]
    s = Junkyard::COLORS[:support]
    u = Junkyard::COLORS[:unstoppable]
    case topic.downcase
    when 'attacking'
      "When it's a player's turn they can play an #{a}Attack#{cl}/" +
      "#{u}Unstoppable#{cl} card to attack a player, or a #{s}Support#{cl} " +
      "card (like peels if you wish to heal). Instead of attacking " +
      "when it's their turn, a player can discard cards they " +
      "don't want. If they have no playable cards, they must discard."
    when 'attacked'
      "#{c}Counter#{cl} cards are played by the person being attacked to " +
      "negate or mitigate the damage they receive. If they counter " +
      "an attack with a Grab they must also play an Attack, Support, " +
      "or Unstoppable card face down along with it. If they have " +
      "no counter, they can pass and accept fate."
    when /cards?/
      "Players have 5 cards in their hand. There are 5 types of cards: " +
      "#{a}Attack Cards#{cl} are played on your turn against other players. " +
      "#{u}Unstoppable Cards#{cl} are as well, but cannot be blocked by the " +
      "opponent. #{s}Support Cards#{cl} heal you. #{c}Counter Cards#{cl} " +
      "counter attacks against you. #{p}Power Cards#{cl} either" +
      "affect all players or a random player. They do not consume " +
      "a turn. Play these cards at the beginning of anyone's turn. " +
      "Use #{prefix}help #{plugin} <card> for card-specific info."
    when /commands?/
      "c/cards - show cards and health, d/discard - discard, " +
      "drop - remove yourself from the game, drop bot - drop me," +
      "pa/pass - pass, p/play - play cards, s/score - show score, " +
      "t/turn - show current turn/order/health"
    when /drop(ping)?/
      "Type 'drop' to drop from the game, or " +
      "'drop bot' to drop the bot from the game."
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
      "#{c}Block#{cl} - Block a basic attack card when played against you. " +
      "Can be used against a grab to nullify the grab's proceeding attack."
    when 'dodge'
      "#{c}Dodge#{cl} - Similar to a block, but the attack " +
      "is passed onto the next player. Cannot counter a grab."
    when 'grab'
      "#{c}Grab#{cl} - Play this as a counter so you can attack back. " +
      "This cannot be dodged. Also note this can be played before " +
      "an attack to disguise your type of attack."
    when /wet( pillow)?/, 'pillow'
      "#{c}Wet Pillow#{cl} - Reduces opponent's attack by 2 points."
    when /credit( feed)?/, 'feed'
      "#{c}Credit Feed#{cl} - Can only be used against a " +
      "blockable killing blow. Resets you to 5 health points."
    when /roach( approach)?/, 'approach'
      "#{a}Roach Approach#{cl} (-0) - This does no damage, " +
      "but your opponent must spend 2 turns in therapy."
    when /broken( heart)?/, /jurr*ass*ic( ?bark)?/, 'heart', 'bark'
      "#{a}Broken Heart#{cl} (-2) - Opponent must watch " +
      "Jurassic Bark, lose 2 health, and a turn."
    when /gut( ?punch)?/, 'punch'
      "#{a}Gutpunch#{cl} (-2) - Basic TODD-inspired technique."
    when 'chihiro'
      "#{a}Chihiro#{cl} (-3) - Chihiro claws your opponent in an excited " +
      "rage. She pees a little. Opponent loses a turn to clean it up."
    when /neck( ?punch)?/
      "#{a}Neck Punch#{cl} (-3) - Slightly more powerful " +
      "attack directed at the neck of your opponent."
    when /kick( ?ball)?/
      "#{a}Kickball#{cl} (-4) - Major damage due to a swift kick " +
      "in the balls. Can be used on players that don't have balls."
    when 'touch'
      "#{a}Touch#{cl} (-5) - LordKaT appears to deliver an ultimate attack."
    when /looke( ?out)?/
      "#{u}Looke Out#{cl} (-0) - Looke's in town! He Says he's going " +
      "to visit. Opponent loses a turn to wait for him. (He never comes.)"
    when /danger( ?zone)?/, 'zone'
      "#{u}Danger Zone#{cl} (-1) - Roach scrobbles Danger Zone 570 times " +
      "on your opponent's computer and now their music libraries are SUPER."
    when /(a ?)?gun/
      "#{u}A Gun#{cl} (-2) - Can't dodge a gun. Simple as that."
    when /rocket(( ?lawn)? ?chair)?/, 'lawn', 'chair'
      "#{u}Rocket Lawn Chair#{cl} (-3) - Still not as good as shotgun."
    when /flippers?/
      "#{u}Flipper#{cl} (-0) - Opponent drops " +
      "all their cards and draws new ones."
    when /garbage( ?man)?/, 'man'
      "#{u}Garbage Man#{cl} (-0) - Give a player all your cards " +
      "you don't want. The opponent won't get any new cards until " +
      "they manage to get their hand below 5 cards again."
    when /heal( ?steal)?/, 'steal'
      "#{u}Heal Steal#{cl} (+0 to +#{MAX_HP-1}) - Steal all of an " +
      "opponent's DDP and peels, if he has any, and use them on yourself."
    when /slot( ?machine)?/, 'machine'
      "#{u}Slot Machine#{cl} (-0 to -9) - Spits out three " +
      "random attack values from 0 to 3. Attack does the " +
      "sum of the three numbers. Can't be blocked."
    when 'ddp'
      "#{s}DDP#{cl} (+1) - Take a sip. Relax. Gain health."
    when /peel(s|z)/
      "#{s}Peelz#{cl} (+2) - Heal yourself by 2 points, up to a " +
      "maximum of #{MAX_HP}. Can be played instead of attacking."
    when 'armor'
      "#{s}Armor#{cl} (+5) - Adds 5 extra points to your " +
      "health on top of your maximum. Your main HP will " +
      "be protected until the armor is depleted."
    when /white( ?wedding)?/, 'wedding'
      "#{s}White Wedding#{cl} (#{MAX_HP-1}) - It's a nice day " +
      "to... START AGAIN!!!! HEALTH RESTORED!!! (can only " +
      "be used if you have exactly 1 health remaining)"
    when /deflect(ed|or|ing|s)?/
      "#{p}Deflector#{cl} - Next attack played against you " +
      "automatically attacks a random player that isn't you."
    when /f+/
      "#{p}FFFFFF#{cl} - Inflicts 6 damage " +
      "to a random player (including you)."
    when /it\'?s(( ?getting)? ?windy)?/, 'getting', 'windy'
      "#{p}It's Getting Windy#{cl} - All players choose " +
      "a random card from the player previous to them."
    when /loot( bag)?/, 'bag'
      "#{p}Loot Bag#{cl} - Player draws until he has 8 cards in his hand."
    when /multi-?( ?ball)?/, 'ball'
      "#{p}Multi-ball#{cl} - Take an extra turn after your turn."
    when /shifty( ?business)?/, 'business'
      "#{p}Shifty Business#{cl} - Swap hand cards with a random player."
    when /the( ?be*s*)?/, /be*s*/
      "#{p}THE BEES#{cl} - Random player is stung by bees and " +
      "must do their best Nicholas Cage impression. Also, " +
      "-1 health every turn until player uses a support card."
    when 'whirlwind'
      "#{p}Whirlwind#{cl} - Every player shifts the cards " +
      "in their hands over to the player beside them."
    when /you('?re|r)(( ?you('?re|r))?( ?grand(father|pa))?)?/, /grand(father|pa)/
      "#{p}You're Your Grandfather#{cl} - Time is moving backwards! REVERSE " +
      "playing order, (or just skip opponent's turn if a 2-player game.)"
    else
      "#{TITLE} help topics: commands, objective, stats, " +
      "#{Bold}Rules:#{Bold} attacking, attacked, cards, grabbing"
    end
  end

  Config.register Config::IntegerValue.new('junkyard.countdown',
    :default => 20, :validate => Proc.new{|v| v > 2},
    :desc => "Number of seconds before starting a game of Junkyard.")

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
          [ "Don't make me take you and this " +
            "#{TITLE} outside, #{m.source.nick}.",
            "Sorry, #{m.source.nick}, this is between me and the guys.",
            "What do you need, #{m.source.nick}?"
          ]
        m.reply retort.sample
      end
      @bot.notice m.sourcenick, g.p_cards(p)
    when /^(di?|discard)\b/
      return unless g.has_turn?(m.source)
      a = msg.split(' ')
      g.discard(a)
    when /^drop bot\b/, "drop #{@bot.nick.downcase}"
      return unless b = g.get_player(@bot.nick)
      if g.players.length > 2
        g.drop_player(b) if g.started
      else
        stop_game(m)
      end
    when /^drop\b/
      return if p.nil?
      if g.started
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
      return unless g.started
      request = msg.split(' ')
      return if request.length < 2
      request.delete_at(0) # => [ "frank", "2", "4" ]
      if g.has_turn?(m.source)
        g.play_move(request)
      else
        g.play_counter(p, request)
      end
    when /^(od?|order)\b/, /^(tu?|turn)\b/
      m.reply g.p_order if g.started
    when /^(sc?|scores?)\b/
      m.reply g.p_damage if g.started
    end
  end

  def add_bot(m, plugin)
    unless @games.key?(m.channel)
      @games[m.channel] = Junkyard.new(self, m.channel, self.registry, m.source)
    end
    g = @games[m.channel]
    g.add_player(@bot.nick)
  end

  def create_game(m, plugin)
    if @games.key?(m.channel)
      user = @games[m.channel].manager
      if m.source == user
        m.reply "...you already started a #{TITLE}"
        return
      else
        m.reply "#{user} already started a #{TITLE}"
        return
      end
    end
    @games[m.channel] = Junkyard.new(self, m.channel, self.registry, m.source)
  end

  # Called from within the game.
  def remove_game(channel)
    @games.delete(channel)
  end

  def stop_game(m, plugin=nil)
    @games.delete(m.channel)
    m.reply "#{TITLE} stopped."
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
        m.reply "No one has played #{TITLE} in #{x}."
      elsif x == m.source.nick
        m.reply "You haven't played #{TITLE}"
      else
        m.reply "#{x} hasn't played #{TITLE}"
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


plugin = JunkyardPlugin.new

plugin.map 'brawl bot',
  :private => false, :action => :add_bot, :auth_path => 'bot'
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
plugin.default_auth('bot', false)
