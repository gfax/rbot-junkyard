# coding: UTF-8
#
# :title: Rumble
#
# Author:: Lite <degradinglight@gmail.com>
# Copyright:: (C) 2012 gfax.ch
# License:: GPL
# Version:: 2013-03-02
#

class Rumble

  TITLE = Bold + "Rumble!" + Bold
  MAX_HP = 10
  COLORS = { :attack => Bold + Irc.color(:lightgray,:black),
             :counter => Bold + Irc.color(:green,:black),
             :power => Bold + Irc.color(:brown,:black),
             :support => Bold + Irc.color(:teal,:black),
             :unstoppable => Bold + Irc.color(:yellow,:black),
             :skips => Irc.color(:purple),
             :- => Irc.color(:red),
             :+ => Irc.color(:blue)
           }
  # Custom death messages:
  DEATHS = [ "Better luck next time, %{p}.",
             "R.I.P. %{p}. Too soon.",
             "%{p} died.",
             "%{p} fell victim to HURT disease.",
             "%{p} expired.",
             "%{p} has been summoned by the Eternal Judge.",
             "%{p} has gone upstream with the salmon.",
             "%{p} is broken beyond repair.",
             "%{p} left the stage.",
             "%{p}: Loser even unto death.",
             "%{p} paid the ultimate price.",
             "%{p} perished.",
             "%{p} shuffles off this mortal coil.",
             "%{p} was discharged from mortality.",
             "%{p} has foregone the finer things in life, like winning.",
             "%{p}'s ded.",
             "%{p}'s soul has passed on."
           ]
  BOT_DEATHS = [ "has seen better days",
                 "lived a better life than all you fools.",
                 "gives his last regards to Chanserv.",
                 "goes to meet that ol' pi in the sky.",
                 "wills his pancake collection to %{r}",
                 "wills his belongings to no one!",
                 "died the most honorable death.",
                 "can't feel his legs, but only because he has none."
               ]
  # Things to say to non-players.
  RETORTS = [ "Don't make me take you behind the tool shed, %{p}.",
              "You don't have any cards, %{p}. I wonder why that is.",
              "Sorry, %{p}, this is between me and the guys.",
              "What do you need, %{p}?"
            ]
  # Add to or modify these as you wish.
  CARDS = {
      :block => {
        :type => :counter,
        :string => "%{p} blocks %{o}'s %{c}.",
        :regex => 'block',
        :help => "Block a basic attack card when played against you. Can be " +
                 "used against a grab to nullify the grab's proceeding attack."
      },
      :dodge => {
        :type => :counter,
        :string => "%{p} dodges %{o}'s %{c}.",
        :regex => [ /dodg/ ],
        :help => "Similar to a block, but the attack is passed" +
                 "onto the next player. Cannot counter a grab."
      },
      :grab => {
        :type => :counter,
        :string => "%{p} grabs %{o}. Respond or pass, %{o}.",
        :regex => 'grab',
        :help => "Play this as a counter so you can attack back. This " +
                 "cannot be dodged. Also note this can be played before " +
                 "an attack to disguise your type of attack."
      },
      :mattress => {
        :type => :counter,
        :health => 2,
        :string => "%{p} holds up an old mattress in defense.",
        :regex => [ /mattres/ ],
        :help => "Reduces opponent's attack by 2 points."
      },
      :insurance => {
        :type => :counter,
        :health => 5,
        :string => "%{p} uses health insurance and " +
                  "is restored to 5 health!",
        :regex => [ /insurance/ ],
        :help => "Can only be used against a blockable, " +
                 "killing blow. Resets you to 5 health points."
      },
      :wrench => {
        :type => :attack,
        :string => "%{p} throws a wrench in %{o}'s gears.",
        :skips => 2,
        :regex => [ /wrench/ ],
        :help => "Throw a wrench in your opponents' machinery. " +
                 "He must spend 2 turns finding what jammed his gears."
      },
      :nose_bleed => {
        :type => :attack,
        :health => -2,
        :string => "%{p} pops %{o} in the nose, spraying blood everywhere.",
        :skips => 1,
        :regex => [ /nose/, /bleed/ ],
        :help => "Opponent loses a turn to clean it up."
      },
      :gutpunch => {
        :type => :attack,
        :health => -2,
        :string => "%{p} punches %{o} in the guts.",
        :regex => [ /gut/, 'punch' ],
        :help => "Basic attack."
      },
      :neck_punch => {
        :type => :attack,
        :health => -3,
        :string => "%{p} delivers %{o} a punch in the neck.",
        :regex => [ /neck/ ],
        :help => "Slightly more powerful attack " +
                 "directed at the neck of your opponent."
      },
      :battery_acid => {
        :type => :attack,
        :health => -3,
        :string => "%{p} throws battery acid in %{o}'s eyes.",
        :skips => 1,
        :regex => [ /battery/, /acid/ ],
        :help => "Opponent is burned by battery acid and blinded for a turn."
      },
      :kickball => {
        :type => :attack,
        :health => -4,
        :string => "%{p} delivers %{o}'s private belongings a swift kick.",
        :regex => [ /kick/, /ball/ ],
        :help => "Major damage due to a swift kick in the balls. " +
                 "Can be used on players that don't have balls."
      },
      :uppercut => {
        :type => :attack,
        :health => -5,
        :string => "%{o} receives an uppercut from %{p}.",
        :regex => [ /upper/ ],
        :help => "Ultimate attack."
      },
      :slot_machine => {
        :type => :attack,
        :string => "Next time stick to the pachinkos, %{o}.",
        :regex => [ /slot/, /machine/ ],
        :help => "Spits out three random attack values from 0 " +
                 "to 3. Attack does the sum of the three numbers."
      },
      :bulldozer => {
        :type => :unstoppable,
        :string => "%{p} bulldozes all the cards out of %{o}'s hand.",
        :regex => [ /bull/, /dozer/ ],
        :help => "Push all of your opponent's hand cards into " +
                 "the discard, leaving him vulnerable to attack."
      },
      :crane => {
        :type => :unstoppable,
        :string => "%{p}'s crane dumps some garbage cards on %{o}.",
        :regex => [ /crane/ ],
        :help => "Pick up all your cards you don't want and dump them on an " +
                 "opponent. The opponent won't get any new cards until " +
                 "he manages to get his hand below 5 cards again."
      },
      :tire => {
        :type => :unstoppable,
        :string => "%{p} throws a tire around %{o}.",
        :skips => 1,
        :regex => [ /tire(d|s)?\b/ ],
        :help => "Throw a tire around your opponent, impeding " +
                 "his movement and causing him to lose a turn."
      },
      :trout_slap => {
        :type => :unstoppable,
        :health => -1,
        :string => "%{p} slaps %{o} around a bit with a large trout.",
        :regex => [ /trout/, /slap/ ],
        :help => "An mIRC-inspired attack. Slap your opponent with a trout."
      },
      :a_gun => {
        :type => :unstoppable,
        :health => -2,
        :string => "%{p} shoots %{o} in the FACE.",
        :regex => [ /(a ?)?gun/ ],
        :help => "Can't dodge a gun. Simple as that."
      },
      :tire_iron => {
        :type => :unstoppable,
        :health => -3,
        :string => "%{p} whacks %{o} upside the head with a tire iron.",
        :regex => [ /tire( |-)?iron/, 'iron' ],
        :help => "Beat your defenseless opponent senseless."
      },
      :mouseraid => {
	:name => 'Mouse Raid',
        :type => :unstoppable,
        :string => "%{p} sends ninja mice into %{o}'s lunchbox to swipe coffee and bacon.",
        :regex => [ /mouse/, /raid/ ],
        :help => "Steal all of an opponent's coffee and bacon, " +
                 "if he has any, and use them on yourself."
      },
      :coffee => {
        :type => :support,
        :health => 1,
        :string => "%{p} sips on some delicious, expensive Starbucks coffee, and relaxes. aaahhh...",
        :regex => [ /coffee/ ],
        :help => "Take a sip. Relax. Gain up to #{MAX_HP} health."
      },
      :bacon => {
        :type => :support,
        :health => 2,
        :string => "%{p} eats a delicious strip of BACON.",
        :regex =>  [ /bacon/ ],
        :help => "Heal yourself by 2 points, " +
                 "up to a maximum of #{MAX_HP}."
      },
      :armor => {
        :type => :support,
        :health => 5,
        :string => "%{p} buckles on some armor.",
        :regex => 'armor',
        :help => "Adds 5 extra points to your health on top of your maximum. " +
                 "Your main HP will be protected until the armor is depleted."
      },
      :surgery => {
        :type => :support,
        :health => MAX_HP - 1,
        :string => "%{p} undergoes surgery and is completely restored!",
        :regex => [ /s(e|u)rg(e|u)r/ ],
        :help => "Used only when you have 1 health. " +
                 "Resets health to #{MAX_HP}."
      },
      :avalanche => {
        :type => :power,
        :health => -6,
        :string => "%{p} causes an avalanche to fall on %{o}!",
        :regex => [ /avalanch/ ],
        :help => "A scrap pile avalanches! 6 damage to " +
                 "any random player, including yourself!."
      },
      :deflector => {
        :type => :power,
        :string => "%{p} raises a deflector shield!",
        :regex => [ /deflect/ ],
        :help => "Next attack played against you automatically " +
                 "attacks a random player that isn't you."
      },
      :earthquake => {
        :type => :power,
        :health => -1,
        :string => "%{p} shakes everybody up with an earthquake!",
        :regex =>  [ /earth/, /quake/ ],
        :help => "An earthquake shakes the entire #{TITLE} " +
                 "1 damage to everyone, starting with yourself."
      },
      :theterror => {
        :name => 'TERROR!',
        :type => :power,
        :string => "%{p} brings the TERROR! Everyone turns pale with fright.",
        :regex => [ /terror/, /multi/ ],
        :help => "Take an extra turn after your turn. Let 'em HAVE IT."
      },
      :reverse => {
        :type => :power,
        :string => "%{p} reverses the table!",
        :regex => [ /reverse/ ],
        :help => "REVERSE playing order. Skip " +
                 "opponent's turn if a 2-player game."
      },
      :shifty_business => {
        :type => :power,
        :string => "%{p} swaps hands with %{o}!",
        :regex => [ /shift/, /business/ ],
        :help => "Swap hand cards with a random player."
      },
      :the_ants => {
        :name => 'THE ANTS',
        :type => :power,
        :string => "%{p} drops an ant farm on %{o}'s head...",
        :regex => [ /the/, /ants/ ],
        :help => "Random player is bitten by ants and must do " +
                 "their best Aquabats impression! 1 damage " +
                 "every turn until victim uses a support card."
      },
      :toolbox => {
        :type => :power,
        :string => "%{p} pulls %{n} cards from the deck.",
        :regex => [ /tool/, /box/, /bag/ ],
        :help => "Draw until you have 8 cards in your hand."
      },
      :windy => {
        :name => 'It\'s Getting Windy',
        :type => :power,
        :string => "%{p} turns up the ceiling fan too high and blows up " +
                  "a gust! Every player passes a random card forward.",
        :regex => [ /it\'?s\b/, /getting/, /windy/ ],
        :help => "All players choose a random card " +
                 "from the player previous to them."
      },
      :whirlwind => {
        :type => :power,
        :string => "A whirlwind causes everyone to rotate hand cards!",
        :regex => [ /whirl( |-)?wind/ ],
        :help => "Every player shifts their hand cards " +
                 "over to the player in front of them."
      }
  }

  class Card

    attr_reader :id, :name, :health, :skips, :string, :type

    def initialize(id)
      @id = id
      if CARDS[id].nil?
        raise 'Invalid card name.'
        return
      end
      @type = CARDS[id][:type]
      @name = CARDS[id][:name]
      @name = id.to_s.split('_').each{|w| w.capitalize!}.join(' ') if @name.nil?
      @health = CARDS[id][:health] || 0
      @skips = CARDS[id][:skips] || 0
      @string = CARDS[id][:string]
    end

    def to_s
      color = COLORS[type]
      hs = if health.zero? then ''
           elsif health < 0 then COLORS[:-] + health.to_s
           else COLORS[:+] + '+' + health.to_s
           end
      ss = if skips.zero?
             ''
           elsif hs == ''
             COLORS[:skips] + skips.to_s
           else
             Irc.color(:white) + '/' +
             COLORS[:skips] + skips.to_s
           end
      color + "#{name} #{hs}#{ss}" + NormalText
    end

  end


  class Player

    attr_reader :user
    attr_accessor :ants, :bonuses, :cards, :damage, :deflector, :deflectors,
                  :discard, :garbage, :glutton, :grabbed, :health, :theterror,
                  :skips, :skip_count

    def initialize(user)
      @user = user        # p.user => unbolded, p.to_s => bolded
      @ants = false       # player is attacked by ants when true
      @bonuses = 0        # counter for end-of-game bonuses
      @cards = []         # hand cards
      @damage = 0         # total damage dished out
      @deflector = false  # deflects attacks when true
      @deflectors = 0     # counter for end-of-game bonuses
      @discard = nil      # card the player just played
      @garbage = nil      # array of Garbage Man garbage cards
      @glutton = 0        # counter for end-of-game bonuses
      @grabbed = false    # currently being grabbed
      @health = MAX_HP    # initial health
      @theterror = false  # gets to go again when true
      @skips = 0          # skips player when > 0
      @skip_count = 0     # counter for end-of-game bonuses
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

  def initialize(plugin, channel, manager)
    @channel = channel
    @plugin = plugin
    @bot = plugin.bot
    @attacked = nil     # player being attacked
    @deck = []          # card stock
    @discard = []       # used cards
    @dropouts = []      # users that aren't allowed to rejoin
    @manager = manager  # user that started the game
    @players = []       # players currently in game
    @registry = @plugin.registry
    @slots = []         # slot machine damage
    @started = nil      # time the game started
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
      @deck << Card.new(:bacon)
    end
    6.times do
      @deck << Card.new(:dodge)
    end
    5.times do
      @deck << Card.new(:block)
      @deck << Card.new(:uppercut)
    end
    3.times do
      @deck << Card.new(:mattress)
      @deck << Card.new(:nose_bleed)
      @deck << Card.new(:coffee)
    end
    2.times do
      @deck << Card.new(:a_gun)
      @deck << Card.new(:battery_acid)
      @deck << Card.new(:insurance)
      @deck << Card.new(:mouseraid)
      @deck << Card.new(:slot_machine)
      @deck << Card.new(:surgery)
      @deck << Card.new(:tire)
      @deck << Card.new(:trout_slap)
      @deck << Card.new(:wrench)
    end
    1.times do
      @deck << Card.new(:armor)
      @deck << Card.new(:avalanche)
      @deck << Card.new(:bulldozer)
      @deck << Card.new(:crane)
      @deck << Card.new(:deflector)
      @deck << Card.new(:earthquake)
      @deck << Card.new(:theterror)
      @deck << Card.new(:reverse)
      @deck << Card.new(:shifty_business)
      @deck << Card.new(:the_ants)
      @deck << Card.new(:tire_iron)
      @deck << Card.new(:toolbox)
      @deck << Card.new(:whirlwind)
      @deck << Card.new(:windy)
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
    @players.shuffle!
    @started = Time.now
    say p_turn
    players.each { |p| notify p, p_cards(p) }
    Thread.new do
      sleep(@bot.config['rumble.bot_delay'])
      bot_move
    end
  end

  def add_player(user)
    if p = get_player(user)
      if p.user == @bot.nick
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
      countdown = @bot.config['rumble.countdown']
      @bot.timer.add_once(countdown) { start_game }
      say "Game will start in #{Bold}#{countdown}#{Bold} seconds." 
      say "Let's get ready to #{Bold}RUMBLE!#{Bold}"
    end
  end

  def drop_player(dropper, player, killed=true)
    unless dropper == false or dropper.user == manager or dropper == player
      say "Only the game manager is allowed to drop others, #{dropper}."
      return
    end
    if dropper
      # If the manager drops the only other player, end the game.
      if dropper.user == manager and dropper != player and players.length < 3
        say "#{player} has been removed from the game. #{TITLE} stopped."
        @plugin.remove_game(channel)
        return
      end
    end
    if killed
      player.damage = 0
      update_user_stats(player, 0)
      if player.user == @bot.nick
        @bot.action channel, BOT_DEATHS.sample % { :r => players.first.user }
      else
        say DEATHS.sample % { :p => player }
      end
    else
      say "#{player} has been removed from the game."
    end
    if player == attacked and not killed
      # Pass any attacks on before removing player.
      n = 0
      n += 1 until players[n] == player
      if next_turn(n).zero?
        increment_turn
      else
        players[next_turn(n)].grabbed = true if attacked.grabbed = true
        attacked.discard, attacked.grabbed = nil
        @attacked = players[next_turn(n)]
        say p_turn
      end
    elsif player == players.first
      increment_turn
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

  def current_discard
    return TITLE + " hasn't started yet." unless started
    d_string = "Current discard is %{c}"
    g_string = "%{o} has been grabbed by %{p}. " +
               "Current discard is #{Bold}face down#{Bold}."
    if attacked
      if attacked.grabbed
        return g_string % { :o => attacked.user, :p => players.first }
      elsif players.first.grabbed
        return g_string % { :o => players.first.user, :p => attacked }
      elsif players.first.discard
        return d_string % { :c => players.first.discard.to_s }
      else
        return d_string % { :c => attacked.discard.to_s }
      end
    end
    return "#{players.first} hasn't attacked yet."
  end

  def ant_recover(player)
    if player.ants
      say "#{player} recovers from ant allergies."
      @discard << player.ants
      player.ants = false
    end
  end

  def has_turn?(src)
    return false unless started
    return true if src == players.first.user
    return false
  end

  def valid_insurance?(player, opponent)
    ants = if player.ants then -1 else 0 end
    damage = if opponent.discard then opponent.discard.health else 0 end
    ensuing_health = player.health + damage + ants
    if opponent.discard and opponent.discard.id == :slot_machine
      slots.each { |n| ensuing_health -= n }
    end
    return true if ensuing_health < 1 and not player.deflector
    return false
  end

  def p_cards(player)
    n = 0
    c = Bold + Irc.color(:white,:black)
    cards = player.cards.map { |k| n += 1; "#{c}#{n}.\)#{Bold} #{k}"}
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
    return "It's #{players.first}'s turn." if attacked.nil?
    return "Respond to #{players.first.user} or pass, #{attacked}."
  end

  def check_health(player=nil)
    unless player.nil?
      drop_player(false, player) if player.health < 1
      return
    end
    players.each do |p|
      drop_player(false, p) if p.health < 1
    end
  end

  def discard(a)
    player = players.first
    if attacked
      say "You can only discard at the start of your turn."
      return
    elsif a.length.zero?
      say "Specify which card(s) you wish to discard."
      return
    end
    c = []
    a.each do |e|
      n = e.to_i
      if n < 1
        notify player, "Specify a card number."
        return
      elsif n > player.cards.length
        notify player, "You don't even have #{n} cards."
        return
      end
      # Numbers are converted into cards.
      c << player.cards[n-1].dup
    end
    player.delete_cards(c)
    s = if c.length == 1 then '' else 's' end
    say "#{player} discards #{c.length} card#{s}."
    deal(player, c.length)
    increment_turn
  end

  def pass(player)
    if player == players.first
      do_move(attacked, players.first, wait=false)
    else
      do_move(players.first, attacked, wait=false)
    end
    increment_turn
  end

  def bot_inventory(player)
    # Make an inventory of what the bot has.
    c_hash = { :support => [], :surgery => [],
               :counter => [], :dodge => [], :grab => [], :insurance => [],
               :unstoppable => [], :attack => [], :power => [],
               :deflector => [], :theterror => [], :toolbox => []
             }
    player.cards.each do |c|
      case c.id
      when :deflector, :dodge, :grab, :insurance, :theterror, :surgery, :toolbox
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
    card = if c_hash[:deflector].any? or c_hash[:theterror].any?
             c_hash[:deflector].first || c_hash[:theterror].first
           elsif c_hash[:toolbox].any?
             c_hash[:toolbox].first
           elsif p.health == 1 and c_hash[:surgery].any?
             c_hash[:surgery].first
           elsif p.ants and c_hash[:support].any?
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
      if card.id == :crane and p.cards.length > 1
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
      play_move(a)
    else
      a = Array.new(p.cards.length) { |i| i + 1 }
      # Don't discard the first card in the hand if we can help it.
      a.shift unless a.length < 2
      discard(a)
    end
    Thread.new do
      sleep(@bot.config['rumble.bot_delay'])
      bot_move if card.type == :power
    end
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
    if valid_insurance?(p, o) and c_hash[:insurance].any?
      card = c_hash[:insurance].first
    elsif p.ants and c_hash[:grab].any? and c_hash[:support].any?
      card = c_hash[:grab].first
      card2 = c_hash[:support].first
    elsif not p.grabbed and c_hash[:dodge].any?
      card = c_hash[:dodge].first
    elsif p.health <= (MAX_HP/2) and c_hash[:grab].any? and c_hash[:support].any?
      card = c_hash[:grab].first
      card2 = c_hash[:support].first
    elsif p.health <= (MAX_HP/2) and c_hash[:counter].any?
      card = c_hash[:counter].first
    elsif c_hash[:counter].any?
      card = if o.discard.health <= -3
               c_hash[:counter].first
             else
               case rand(2)
               when 0 then c_hash[:counter].first
               else nil
               end
             end
    elsif c_hash[:grab].any? and c_hash[:unstoppable].any?
      case rand(4)
      when 0..2
        card = c_hash[:grab].first
        card2 = c_hash[:unstoppable].first
      else 
        card = nil
      end
    elsif c_hash[:grab].any? and c_hash[:attack].any?
      case rand(4)
      when 0..2
        card = c_hash[:grab].first
        card2 = c_hash[:attack].first
      else
        card = nil
      end
    else
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
      play_counter(p, a)
    else
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
    # Process card information.
    c = []
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
        do_grab(player, opponent, c)
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
    if player.discard.id == :crane
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

  def do_grab(player, opponent, c)
    if c[1].nil?
      notify player, "Play an attack when grabbing."
      return
    elsif c[1].type == :counter or c[1].type == :power
      notify player, "You can't play a #{c[1].type} card when grabbing."
      return
    elsif c[1].id == :surgery
      dmg = opponent.discard || 0
      unless player.health + dmg <= 1
        notify player, "You can only use that card with 1 health."
        return
      end
    elsif c[1].id == :crane
      player.garbage = c[2..-1]
    end
    do_move(opponent, player, wait=false) if player == attacked
    return if player.health < 1 # In case a player dies trying to grab.
    @discard |= [ c[0], c[1] ]
    player.discard = c[1]
    do_slots(player)
    player.delete_cards([c[0], c[1]])
    @attacked = opponent unless attacked
    opponent.grabbed = true
    say c[0].string % { :p => player, :o => opponent }
    notify opponent, p_cards(opponent)
    Thread.new do
      sleep(2)
      bot_counter
    end
  end

  def do_power(player, card)
    unless attacked.nil?
      notify player, "You cannot play power cards in the middle of an attack."
      return
    end
    # Ants/Deflector are discarded when used up.
    @discard << card unless card.id == :deflector or card.id == :the_ants
    player.delete_cards(card)
    case card.id
    when :avalanche
      victim = players[rand(players.length)]
      victim.health += card.health
      player.damage += card.health.abs
      say card.string % { :p => player, :o => victim }
      say p_health(victim)
      check_health(victim)
    when :deflector
      player.deflector = card
      say card.string % { :p => player }
    when :earthquake
      say card.string % { :p => player }
      players.each do |p|
        p.health += card.health
        player.damage += card.health.abs
      end
      say p_health
      check_health
    when :theterror
      player.theterror = true
      say card.string % { :p => player }
    when :shifty_business
      n = rand(players.length)
      while players[n] == player
        n = rand(players.length)
      end
      say card.string % { :p => player, :o => players[n] }
      player.cards, players[n].cards = players[n].cards, player.cards
      notify(player, p_cards(player)) unless player == players.first
    when :the_ants
      n = rand(players.length)
      players[n].ants = card
      say card.string % { :p => player, :o => players[n] }
    when :toolbox
      n = if player.cards.length > 8 then 0 else 8 - player.cards.length end
      deal(player, n)
      say card.string % { :p => player, :n => n }
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
      players.each do |p|
        notify p, p_cards(p) unless p == player
      end
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
        notify players[n], p_cards(players[n]) unless players[n] == player
        n += 1
      end
    when :reverse
      say card.string % { :p => player }
      if players.length == 2 and player != players.first
        increment_turn
        return
      elsif players.length > 2
        tmp = @players.reverse
        (tmp.length-1).times do
          tmp << tmp.shift
        end
        @players = tmp
      end
    end
    # In the rare event the current player has
    # no more cards, pass to the next player.
    increment_turn if players.first.cards.length.zero?
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
      opponent.deflectors += 1
      @attacked = players[n]
      opponent = players[n]
      opponent.grabbed = false
      wait = false
    end
    case player.discard.type
    when :attack
      if wait
        do_slots(player) # Get some new slots while we wait.
        say "#{player} plays #{player.discard}. Respond or pass, #{opponent}."
        notify opponent, p_cards(opponent)
        @attacked = opponent
        Thread.new do
          sleep(2)
          bot_counter
        end
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
      # Adjust damage depending if opponent has a mattress.
      if opponent.discard
        if opponent.discard.id == :mattress
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
      player.glutton += 1
      ant_recover(player)
    when :unstoppable
      if opponent.discard
        if opponent.discard.type == :counter
          say "#{opponent}'s #{opponent.discard} was thwarted!"
        end
      end
      case player.discard.id
      when :bulldozer
        until opponent.cards.length < 1
          temp_deck = opponent.cards
          temp_deck.each do |c|
            @discard << c
            opponent.delete_cards(c)
          end
        end
      when :crane
        @discard |= player.garbage
        opponent.cards |= player.garbage
        player.delete_cards(player.garbage)
        deal(player, player.garbage.length)
        player.garbage = nil
      when :mouseraid
        h, temp_deck = player.health, []
        opponent.cards.each do |e|
          if e.id == :coffee or e.id == :bacon
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
    if player.discard.type == :support or player.discard.id == :mouseraid
      if player.discard.id == :mouseraid
        if temp_deck.length > 0
          say "A ninja mouse brings #{player} some #{temp_deck.join(', ')}, and it is delicious!!"
          ant_recover(player)
        end
      end
      say p_health(player)
    elsif player.discard.id != :crane and player.discard.id != :bulldozer
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
      do_grab(player, opponent, c)
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
        Thread.new do
          sleep(2)
          bot_counter
        end
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
      unless valid_insurance?(player, opponent)
        notify player, "You can only use that card " +
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

  def elapsed_time
    if started
      Utils.secs_to_string(Time.now-started).gsub(/\[|\]|"/,'')
    else
      nil
    end
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
    if players.first.theterror
      players.first.theterror = false
    else
      @players << @players.shift
    end
    # Deal the new player some cards.
    player = players.first
    if player.cards.length < 5
      n = 5 - player.cards.length
      deal(player, n)
    end
    if player.ants
      player.health -= 1
      say "#{player} is bitten by THE ANTS."
      say p_health(player)
      check_health(player)
      # Turn will increment when they are dropped.
      return if player.health < 1
    end
    if player.skips > 0
      say "#{player} misses a turn."
      player.skips -= 1
      player.skip_count += 1
      increment_turn
    else
      say p_turn
      notify player, p_cards(player)
      Thread.new do
        sleep(@bot.config['rumble.bot_delay'])
        bot_move
      end
    end
  end

  def next_turn(num=0)
    return 0 if num >= players.length - 1
    return num + 1
  end

  def end_game
    p = players.first
    b_string = ' '
    # Brutality bonus:
    if p.damage >= 20
      p.bonuses += 1
      p.damage += MAX_HP
      b_string << "Brutality bonus: +#{MAX_HP}. "
    end
    # Close-call bonus:
    if p.health == 1
      p.bonuses += 1
      p.damage += MAX_HP - 1
      b_string << "Close-call bonus: +#{MAX_HP - 1}. "
    end
    # Glutton bonus:
    if p.glutton >= 6
      p.bonuses += 1
      p.damage += p.glutton
      b_string << "Glutton bonus: +#{p.glutton}. "
    end
    # Health bonus:
    if p.health >= MAX_HP
      p.bonuses += 1
      p.damage += p.health
      b_string << "Health bonus: +#{p.health}. "
    end
    # Multi-Deflector bonus:
    if p.deflectors > 1
      p.bonuses += 1
      b = MAX_HP + p.deflectors * 2
      p.damage += b
      b_string << "Multi-Deflector bonus: +#{b}. "
    end
    # Where's-the-fight? bonus:
    if p.skip_count >= 7
      p.bonuses += 1
      p.damage += p.skip_count * 2
      b_string << "Where's-the-fight? bonus: +#{p.skip_count * 2}. "
    end
    say "#{p} wins after #{elapsed_time}!#{b_string}Damage done: #{p.damage}"
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
    @registry[channel.name] = [ 0, 0, {} ] unless @registry.has_key? c
    # Player's channel damage:
    player_hash = @registry[c][2]
    if player_hash.has_key? p
      b = player_hash[p][:bonuses] || 0
      player_hash[p] = { :nick => nick,
                         :wins => player_hash[p][:wins] + win,
                         :games => player_hash[p][:games] + 1,
                         :damage => player_hash[p][:damage] + player.damage,
                         :bonuses => b + player.bonuses
                       }
    else
      player_hash[p] = { :nick => nick,
                         :wins => win,
                         :games => 1,
                         :damage => player.damage,
                         :bonuses => player.bonuses
                       }
    end
    @registry[c] = [ @registry[c][0], @registry[c][1], player_hash ]
    # Player's network-wide damage:
    if @registry.has_key? p
      b = @registry[p][:bonuses] || 0
      @registry[p] = { :nick => nick,
                       :wins => @registry[p][:wins] + win,
                       :games => @registry[p][:games] + 1,
                       :damage => @registry[p][:damage] + player.damage,
                       :bonuses => b + player.bonuses
                     }
    else
      @registry[p] = player_hash[p]
    end
  end

end


class RumblePlugin < Plugin

  Config.register Config::BooleanValue.new('rumble.bot',
    :default => false,
    :desc => "Enables or disables the AI.")
  Config.register Config::IntegerValue.new('rumble.bot_delay',
    :default => 3, :validate => Proc.new{|v| v.between?(-1,61)},
    :desc => "Number of seconds for bot to wait before responding.")
  Config.register Config::IntegerValue.new('rumble.countdown',
    :default => 20, :validate => Proc.new{|v| v > 2},
    :desc => "Number of seconds before starting a game of Rumble.")

  TITLE = Rumble::TITLE
  MAX_HP = Rumble::MAX_HP

  attr :games

  def initialize
    super
    @games = {}
  end

  def help(plugin, topic='')
    # Extract help information from CARDS hash.
    id, card = nil, nil
    Rumble::CARDS.each_pair do |key, value|
      a = value[:regex]
      a = a.split if a.kind_of? String
      a.each do |r|
        case topic.downcase
        when r
          id, card = key, value
          break
        end
      end
    end
    # Format and return card information.
    unless card.nil?
      color = Rumble::COLORS[card[:type]]
      name = if card[:name]
               card[:name]
             else
                id.to_s.split('_').each{|w| w.capitalize!}.join(' ')
             end
      health = if card[:health] then " (#{card[:health]} health)" else '' end
      skips = if card[:skips]
                s = if card[:skips] > 1 then 's' else '' end
                " (miss #{card[:skips]} turn#{s})"
              else
                ''
              end
      help = card[:help]
      return color + name + NormalText + health + skips + " - " + help
    end
    # Check other help topics for information.
    prefix = @bot.config['core.address_prefix'].first
    b, cl = Bold, NormalText
    a = Rumble::COLORS[:attack]
    c = Rumble::COLORS[:counter]
    p = Rumble::COLORS[:power]
    s = Rumble::COLORS[:support]
    u = Rumble::COLORS[:unstoppable]
    case topic.downcase
    when 'attacking'
      "#{b}You're Attacking:#{b} When it's your turn to play, you can play " +
      "an #{a}Attack#{cl} or #{u}Unstoppable#{cl} card to attack a player, " +
      "or a #{s}Support#{cl} card if you wish to heal. Instead of attacking " +
      "when it's your turn, you can discard cards you don't want. If you " +
      "have no playable cards, you must discard. After discarding or " +
      "playing an attack, your turn is over."
    when /attack(ed)?/
      "#{b}You're Attacked:#{b} #{c}Counter#{cl} cards are played to negate " +
      "or mitigate the damage you receive when being attacked. If you " +
      "counter an attack with a grab you must also play an #{a}Attack#{cl}, " +
      "#{s}Support#{cl}, or #{u}Unstoppable#{cl} card face down along with " +
      "it. Grabs do not block attacks, but they offer a chance to " +
      "counterattack or heal immediately after you are attacked. Your " +
      "opponent must respond to your grab by countering your hidden card or " +
      "by passing and accepting fate."
    when /bots?/
      "#{b}Bot Matches:#{b} #{prefix}#{plugin} bot to start a game with " +
      "#{@bot.nick}. Type the same command mid-game to have #{@bot.nick} " +
      "join a game in progress.#{unless @bot.config['rumble.bot'] then
      ' This feature is currently disabled on this rbot\'s config.'
      else '' end}"
    when /card/
      "#{b}Cards:#{b} Players have 5 cards in their hand. There are 5 types " +
      "of cards: #{a}Attack#{cl} cards are played against other players on " +
      "your turn. #{u}Unstoppable#{cl} cards are as well, but cannot be " +
      "countered by the opponent. #{s}Support#{cl} cards heal you. " +
      "#{c}Counter#{cl} cards counter attacks against you. #{p}Power#{cl} " +
      "cards either affect all players or a random player. They do not " +
      "consume a turn. Play these cards at the beginning of anyone's turn. " +
      "Use #{prefix}help #{plugin} <card> for card-specific info."
    when /command/
      "#{b}Commands:#{b} c/cards - show cards, cd - current discard, " +
      "d/discard - discard cards, drop <me>/<bot>/<nick> - remove " +
      "yourself/#{@bot.nick}/player from the game, pa/pass - pass, " +
      "p/play - play cards, s/score - show score, t/turn - show current " +
      "turn/order/health, ti/time - time elapsed since game started"
    when /drop/
      "#{b}Dropping:#{b} Type 'drop' to drop from the game, or 'drop bot' to " +
      "drop the bot from the game. Only the game manager (the player that " +
      "started the game,) can drop other players."
    when /grabbing/
      "#{b}Grabbing: #{b}Although a Counter card, you can Grab other " +
      "players on your own turn. You must lay your intended " +
      "#{a}Attack#{cl}, #{u}Unstoppable#{cl}, or #{s}Support#{cl} card with " +
      "the grab. The attacked player doesn't get to see what card is " +
      "attacking them until they respond with counter or pass. Players " +
      "can't dodge when being grabbed. If the card you played while " +
      "grabbing them turns out to be an #{u}Unstoppable#{cl} attack, any " +
      "counter card they play will be nullified and discarded."
    when /objective/
      "#{b}Objective:#{b} Every player has #{MAX_HP} health. " +
      "Play cards against an opponent to take away their health. " +
      "Be the last player standing."
    when /play/
      "#{b}Playing:#{b} Type 'p' or 'play' to play a card number from your " +
      "hand. Example: 'p Frank 4' to attack Frank with your 4th card. " +
      "You only need to specify a username when there are more than 2 " +
      "players playing the game."
    when /stat/, /top/
      "#{b}Stats:#{b} #{prefix}#{plugin} stats <nick> - network-wide stats, " +
      "#{prefix}#{plugin} stats #channel <nick> - channel-specific stats, " +
      "#{prefix}#{plugin} top <num> - top <num> players"
    else
      "#{TITLE} help topics:#{@bot.config['rumble.bot'] ? ' bot,' : ''} " +
      "commands, play, objective, stats; #{b}Rules:#{b} attacking, " +
      "attacked, cards, grabbing"
    end
  end

  def message(m)
    return unless @games.key?(m.channel) and m.plugin
    g = @games[m.channel]
    a = m.message.downcase.split(' ').uniq
    a.delete_at(0) # [ "p", "frank", "2", "4" ] => [ "frank", "2", "4" ]
    p = g.get_player(m.source.nick)
    case m.message.downcase
    when /^(jo?|join)( |\z)/
      g.add_player(m.source)
    when 'cd'
      @bot.say m.channel, g.current_discard
    when /^(ca?|cards?)( |\z)/
      if p.nil?
        m.reply Rumble::RETORTS.sample % { :p => m.source }
        return
      end
      @bot.notice m.sourcenick, g.p_cards(p)
    when /^(di?|discard)( |\z)/
      g.discard(a) if g.has_turn?(m.source)
    when /^drop( |\z)/
      return unless p and g.started
      victim = case a[0]
               when 'me', nil then p
               when 'bot' then g.get_player(@bot.nick)
               else g.get_player(a[0])
               end
      unless victim
        m.reply "There is no one playing named '#{a[0]}'."
        return
      end
      g.drop_player(p, victim, false)
    when /^(pa|pass)( |\z)/
      return unless g.attacked and p
      g.pass(p) if g.attacked == p or p.grabbed
    when /^(pl?|play)( |\z)/
      return if p.nil? or a.length.zero?
      return unless g.started
      if g.has_turn?(m.source)
        g.play_move(a)
      else
        g.play_counter(p, a)
      end
    when /^(od?|order)( |\z)/, /^(tu?|turn)( |\z)/
      @bot.say m.channel, g.p_order if g.started
    when /^(sc?|scores?)( |\z)/
      @bot.say m.channel, g.p_damage if g.started
    when /^ti(me)?( |\z)/
      if g.started
        m.reply "This game has been going on for #{g.elapsed_time}."
      else
        m.reply TITLE + " hasn't started yet."
      end
    end
  end

  def add_bot(m, plugin)
    unless @bot.config['rumble.bot']
      m.reply "Playing against #{@bot.nick} is disabled."
      return
    end
    unless @games.key?(m.channel)
      @games[m.channel] = Rumble.new(self, m.channel, m.source)
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
    @games[m.channel] = Rumble.new(self, m.channel, m.source)
  end

  # Called from within the game.
  def remove_game(channel)
    @games.delete(channel)
  end

  def stop_game(m, plugin=nil)
    if @games[m.channel].nil?
      m.reply "There is no #{TITLE} here."
      return
    end
    remove_game(m.channel)
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
        z = params[:z] || 4
        z = if z.to_i.between?(1,10) then z.to_i - 1 else 4 end
        top_players = a[0..z]
        n = 1
        top_players.each do |k|
          @bot.say m.channel, "#{Bold}#{n}. #{k[:nick]}#{Bold} - " +
                              "#{k[:damage]} dmg (#{k[:wins]}/ " +
                              "#{k[:games]} games won)"
          n += 1
          end
        return
      else
        @bot.say m.channel, "#{Bold}#{@registry[xd][:nick]}#{Bold} -- " +
                            "Wins: #{@registry[xd][:wins]}, " +
                            "games: #{@registry[xd][:games]}, " +
                            "damage: #{@registry[xd][:damage]}, " +
                            "special bonuses: #{registry[xd][:bonuses]}"
        return
      end
    end
    y = params[:y].to_s.downcase
    unless @registry[x][2].has_key? y
      "They haven't played a game in this channel, #{m.source.nick}"
      return
    end
    @bot.say m.channel, "#{Bold}#{@registry[x][2][y][:nick]}#{Bold} " +
                        "(in #{x}) -- Wins: #{@registry[x][2][y][:wins]}, " +
                        "games: #{@registry[x][2][y][:games]}, " +
                        "damage: #{@registry[x][2][y][:damage]}, " +
                        "special bonuses: #{@registry[x][2][y][:bonuses]}"
  end

end


plugin = RumblePlugin.new

[ 'rumble' ].each do |scope|
  plugin.map "#{scope} bot",
    :private => false, :action => :add_bot
  plugin.map "#{scope} cancel",
    :private => false, :action => :stop_game
  plugin.map "#{scope} end",
    :private => false, :action => :stop_game
  plugin.map "#{scope} stat[s] [:x [:y]]",
    :action => :show_stats
  plugin.map "#{scope} stop",
    :private => false, :action => :stop_game
  plugin.map "#{scope} top [:z]",
    :private => false, :action => :show_stats,
    :defaults => { :x => false, :z => 5 }
  plugin.map "#{scope}",
    :private => false, :action => :create_game
end

plugin.default_auth('*', true)
