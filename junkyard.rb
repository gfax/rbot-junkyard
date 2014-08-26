# coding: UTF-8
#
# :title: Junkyard
#
# Author:: Lite <jay@gfax.ch>
# Copyright:: (C) 2014 gfax.ch
# License:: GPL
# Version:: 2014-08-25
#

class Junkyard

  TITLE = Bold + "Junkyard!" + Bold
  MAX_HP = 10
  COLORS = { :attack => Bold + Irc.color(:lightgray,:black),
             :counter => Bold + Irc.color(:green,:black),
             :disaster => Bold + Irc.color(:brown,:black),
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
                 "wills his pancake collection to %{r}.",
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
      :mirror => {
        :type => :counter,
        :string => "%{p} takes %{o}'s %{c} and mirrors it back!",
        :regex => [ /mirr/ ],
        :help => "Mirror your opponent's attack, after taking the damage to yourself."
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
      :grease_bucket => {
        :type => :attack,
        :health => -2,
        :string => "%{p} drops a bucket of grease on %{o}. %{o} goes to wash up.",
        :skips => 1,
        :regex => [ /greas/, /buck/ ],
        :help => "Even more painful than it is messy."
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
      :acid_coffee => {
        :type => :attack,
        :health => -3,
        :string => "%{p} puts some battery acid in %{o}'s coffee. %{o} starts to feel ill...",
        :skips => 1,
        :regex => [ /acid/, /cof(f)ee/ ],
        :help => "Opponent gets sick for a turn due to battery acid being poured in his coffee."
      },
      :kickball => {
        :type => :attack,
        :health => -4,
        :string => "%{p} delivers %{o}'s private belongings a swift kick.",
        :regex => [ /kick/ ],
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
      :magnet => {
        :type => :unstoppable,
        :string => "%{p}'s magnet steals some cards from %{o}.",
        :regex => [ /magn/ ],
        :help => "Discard any cards you don’t want and pull out that many from your opponent’s hand."
      },
      :tire => {
        :type => :unstoppable,
        :skips => 1,
        :string => "%{p} throws a tire around %{o}.",
        :regex => [ /tire(d|s)?\b/ ],
        :help => "Throw a tire around your opponent, impeding " +
                 "his movement and causing him to lose a turn."
      },
      :cheap_shot => {
        :type => :unstoppable,
        :health => -1,
        :string => "%{p} takes a cheap shot at %{o}.",
        :regex => [ /ch(e)ap/, /shot/ ],
        :help => "Hit your opponent when he least expects it."
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
      :meal_steal => {
        :type => :unstoppable,
        :string => "%{p} rummages through %{o}'s lunchbox for soup and subs.",
        :regex => [ /meal/, /steal/ ],
        :help => "Steal all of an opponent's soup and subs, " +
                 "if he has any, and use them on yourself."
      },
      :soup => {
        :type => :support,
        :health => 1,
        :string => "%{p} sips on some soup and relaxes.",
        :regex => [ /soup/ ],
        :help => "Take a sip. Relax. Gain up to #{MAX_HP} health."
      },
      :sub => {
        :type => :support,
        :health => 2,
        :string => "%{p} eats a sub.",
        :regex => 'sub',
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
        :type => :disaster,
        :health => -6,
        :string => "%{p} causes an avalanche to fall on %{o}!",
        :regex => [ /avalanch/ ],
        :help => "A scrap pile avalanches! 6 damage to " +
                 "any random player, including yourself!."
      },
      :deflector => {
        :type => :disaster,
        :string => "%{p} raises a deflector shield!",
        :regex => [ /deflect/ ],
        :help => "Next attack played against you automatically " +
                 "attacks a random player that isn't you."
      },
      :earthquake => {
        :type => :disaster,
        :health => -1,
        :string => "%{p} shakes everybody up with an earthquake!",
        :regex =>  [ /earth/, /quake/ ],
        :help => "An earthquake shakes the entire #{TITLE} " +
                 "1 damage to everyone, starting with yourself."
      },
      :gas_spill => {
        :type => :disaster,
        :skips => 2,
        :string => "%{p} knocks a leak in %{o}'s gas tank! %{o} goes to find a hose and ash tray.",
        :regex => [ /spil/],
        :help => "Random player misses 2 turns."
      },
      :propeller => {
        :type => :disaster,
        :string => "%{p} spins up %{o}'s propeller...",
        :regex => [ /propel/ ],
        :help => "Double the effects of a random player’s next successful Attack/Support."
      },
      :reverse => {
        :type => :disaster,
        :string => "%{p} reverses the table!",
        :regex => [ /reverse/ ],
        :help => "REVERSE playing order. Skip " +
                 "opponent's turn if a 2-player game."
      },
      :shifty_business => {
        :type => :disaster,
        :string => "%{p} swaps hands with %{o}!",
        :regex => [ /shift/, /business/ ],
        :help => "Swap hand cards with a random player."
      },
      :spare_bolts => {
        :type => :disaster,
        :string => "%{p} fixes up an extra turn.",
        :regex => [ /spare/, /bolt/ ],
        :help => "Take an extra turn after your turn."
      },
      :the_bees => {
        :name => 'THE BEES',
        :type => :disaster,
        :string => "%{p} drops the bee cage on %{o}'s head...",
        :regex => [ /be+s/ ],
        :help => "Random player is stung by bees and must do " +
                 "their best Nicholas Cage impression. 1 damage " +
                 "every turn until victim uses a support card."
      },
      :toolbox => {
        :type => :disaster,
        :string => "%{p} pulls %{n} cards from the deck.",
        :regex => [ /tool/, /box/, /bag/ ],
        :help => "Draw until you have 8 cards in your hand."
      },
      :windy => {
        :name => 'It\'s Getting Windy',
        :type => :disaster,
        :string => "%{p} turns up the ceiling fan too high and blows up " +
                  "a gust! Every player passes a random card forward.",
        :regex => [ /it\'?s\b/, /getting/, /windy/ ],
        :help => "All players choose a random card " +
                 "from the player previous to them."
      },
      :whirlwind => {
        :type => :disaster,
        :string => "A whirlwind causes everyone to rotate hand cards!",
        :regex => [ /whirl/, /wind/ ],
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
           elsif health < 0 then COLORS[:-] + ' ' + health.to_s
           else COLORS[:+] + ' +' + health.to_s
           end
      ss = if skips.zero?
             ''
           elsif hs == ''
             COLORS[:skips] + ' ' + skips.to_s
           else
             Irc.color(:white) + '/' +
             COLORS[:skips] + skips.to_s
           end
      color + "#{name}#{hs}#{ss}" + NormalText
    end

  end


  class Player

    attr_accessor :user, :bees, :blocks, :bonuses, :cards, :damage,
                  :deflector, :deflectors, :discard, :garbage,
                  :glutton, :go_again, :grabbed, :hand_max, :health,
                  :propeller, :skips, :skip_count, :turns, :turn_wizard

    def initialize(user, health=MAX_HP)
      @user = user       # p.user => unbolded, p.to_s => bolded
      @bees = false      # player is attacked by bees when true
      @blocks = 0        # counter for "NOPE" bonus
      @bonuses = 0       # counter for end-of-game bonuses
      @cards = []        # hand cards
      @damage = 0        # total damage dished out
      @deflector = nil   # holds instance of deflector card when player has active deflector
      @deflectors = 0    # counter for "Deflector" bonus
      @discard = nil     # card the player just played
      @garbage = nil     # array of cards played with Crane/Magnet
      @glutton = 0       # counter for "Glutton" bonus
      @grabbed = false   # currently being grabbed
      @hand_max = 5      # maximum number of cards to deal up to
      @health = health   # initial health
      @go_again = false  # gets to go again when true
      @propeller = nil   # instance of propeller card if player has active propeller
      @skips = 0         # skips player when > 0
      @skip_count = 0    # counter for "Where's-the-fight?" bonus
      @turns = 0         # turns spent playing this game
      @turn_wizard = 0   # counter for "Turn Wizard" bonus
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
      if propeller
        p1 = Irc.color(:brown) + "+" + NormalText
        p2 = Irc.color(:brown) + "+" + NormalText
      else
        p1 = ''
        p2 = ''
      end
      d1 + p1 + Bold + @user.to_s + Bold + p2 + d2
    end

  end


  attr_reader :attacked, :channel, :deck, :discard, :dropouts,
              :manager, :players, :registry, :slots, :started

  def initialize(plugin, channel, first_player)
    @channel = channel
    @plugin = plugin
    @bot = plugin.bot
    @attacked = nil     # player being attacked
    @deck = []          # card stock
    @discard = []       # used cards
    @dropouts = []      # users that aren't allowed to rejoin
    @manager = nil      # player that started the game
    @players = []       # players currently in game
    @registry = @plugin.registry
    @slots = []         # slot machine damage
    @started = nil      # time the game started
    create_deck
    add_player(first_player)
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
      @deck << Card.new(:mattress)
      @deck << Card.new(:grease_bucket)
      @deck << Card.new(:soup)
    end
    2.times do
      @deck << Card.new(:a_gun)
      @deck << Card.new(:acid_coffee)
      @deck << Card.new(:cheap_shot)
      @deck << Card.new(:insurance)
      @deck << Card.new(:meal_steal)
      @deck << Card.new(:mirror)
      @deck << Card.new(:slot_machine)
      @deck << Card.new(:surgery)
      @deck << Card.new(:tire)
      @deck << Card.new(:wrench)
    end
    1.times do
      @deck << Card.new(:armor)
      @deck << Card.new(:avalanche)
      @deck << Card.new(:bulldozer)
      @deck << Card.new(:crane)
      @deck << Card.new(:deflector)
      @deck << Card.new(:earthquake)
      @deck << Card.new(:gas_spill)
      @deck << Card.new(:magnet)
      @deck << Card.new(:propeller)
      @deck << Card.new(:spare_bolts)
      @deck << Card.new(:reverse)
      @deck << Card.new(:shifty_business)
      @deck << Card.new(:the_bees)
      @deck << Card.new(:tire_iron)
      @deck << Card.new(:toolbox)
      @deck << Card.new(:whirlwind)
      @deck << Card.new(:windy)
    end
    @deck.shuffle!
  end

  def deal(player, n=1)
    return if n < 1
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
    increment_turn
    players.each { |p| notify p, p_cards(p) unless p = players.first }
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
    if started and @bot.config['junkyard.average_hp']
      n = 0
      players.each { |e| n += e.health }
    hp = (n / players.length + 0.5).to_i
    else
    hp = MAX_HP
    end
    p = Player.new(user, hp)
    @players << p
    if manager.nil?
      @manager = p
      say "#{p} starts a #{TITLE} Type 'j' to join."
    else
      say "#{p} joins the #{TITLE}"
    end
    deal(p, p.hand_max)
    if players.length == 2
      countdown = @bot.config['junkyard.countdown']
      @bot.timer.add_once(countdown) { start_game }
      say "Game will start in #{Bold}#{countdown}#{Bold} seconds."
    end
  end

  def drop_player(player, dropper=false)
    unless dropper == false or dropper == manager or dropper == player
      say "Only the game manager is allowed to drop others, #{dropper}."
      return
    end
    # Pass any attacks on before removing a dropped player.
    n = 0
    n += 1 until players[n] == player
    n = next_turn(n)
    if player == manager and players.length > 2
      unless players[n].user == @bot.nick
        @manager = players[n]
      else
        @manager = players[next_turn(n)]
      end
      say "#{manager} is now game manager."
    end
    if dropper
      # If the manager drops the only other player, end the game.
      if dropper == manager and dropper != player and players.length < 3
        say "#{player} has been removed from the game. #{TITLE} stopped."
        @plugin.remove_game(channel)
        return
      end
      say "#{player} has been removed from the game."
      # Pass any existing attacks to the next player (as
      # long as the next player isn't the one attacking).
      unless player == players.first
        if players[n] == players.first
          @attacked = players[next_turn(n)] if player == attacked
          players[next_turn(n)].grabbed = true if player.grabbed
        else
          @attacked = players[n] if player == attacked
          players[n].grabbed = true if player.grabbed
        end
      end
    else
      player.damage = 0
      update_user_stats(player, 0)
      if player.user == @bot.nick
        r = if players.first.user == @bot.nick
              players.last.user
            else 
              players.first.user
            end
        @bot.action channel, BOT_DEATHS.sample % { :r => r }
      else
        say DEATHS.sample % { :p => player }
      end
    end
    if @bot.config['junkyard.reveal_cards']
      reveal_string = if player.cards.length > 0
                        "#{player} had #{player.cards.join(', ')}"
                      else
                         "#{player} had no cards"
                      end
      reveal_string << " and an active #{player.deflector}" if player.deflector
      reveal_string << " while suffering from #{player.bees}" if player.bees
      reveal_string << "."
      say reveal_string
    end
    player.discard = nil
    player.grabbed = false
    @discard |= player.cards
    @discard |= player.crane if player.crane
    @discard << player.bees if player.bees
    @discard << player.deflector if player.deflector
    @dropouts << player
    @players.delete(player)
    if players.length < 2
      end_game
      return
    elsif not dropper
      if attacked
        attacked.discard = nil
        attacked.grabbed = false
        @attacked = nil
      end
    else
      say p_turn
      bot_thread_counter
      bot_thread_move
    end
  end

  def get_player(user, source=nil)
    case user
    when User
      players.each do |p|
        return p if p.user == user
      end
    when String
      players.each do |p|
        return p if p.user.irc_downcase == user.irc_downcase(channel.casemap)
      end
      players.each do |p|
        if p.user.irc_downcase =~ /^#{user.irc_downcase(channel.casemap)}/
          return p unless p.user.irc_downcase == source
        end
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

  def bee_recover(player)
    if player.bees
      say "#{player} recovers from bee allergies."
      @discard << player.bees
      player.bees = false
    end
  end

  def has_turn?(src)
    return false unless started
    return true if src == players.first.user
    return false
  end

  def valid_insurance?(player, opponent)
    bees = if player.bees then -1 else 0 end
    damage = if opponent.discard then opponent.discard.health else 0 end
    ensuing_health = player.health + damage + bees
    if opponent.discard and opponent.discard.id == :slot_machine
      slots.each { |n| ensuing_health -= n }
    end
    return true if ensuing_health < 1 and not player.deflector
    return false
  end

  def propeller(player)
    if player.propeller
      say "#{player} lets loose the #{player.propeller}!"
      @discard << player.propeller
      player.propeller = nil
      return 2
    end
    return 1
  end

  def p_cards(player)
    if player.cards.length > 0
      n, b = 0, Bold
      cards = player.cards.map { |c| n += 1; "#{b}#{n}.\)#{b} #{c}"}
      return cards.join(' ')
    else
      return "#{Bold}(You have no cards!)#{Bold}"
    end
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
      drop_player(player) if player.health < 1
      return
    end
    players.each do |p|
      drop_player(p) if p.health < 1
    end
  end

  def discard(a)
    player = players.first
    if attacked
      notify player, 'You can only discard at the start of your turn.'
      return
    elsif a.length.zero?
      notify player, 'Specify which card(s) you wish to discard.'
      return
    end
    if ['a', 'all'].include? a.first.to_s.downcase
      a = (1..player.cards.length).to_a
    end
    c = []
    a.each do |e|
      n = e.to_i
      if n < 1
        notify player, 'Specify a card number.'
        return
      elsif n > player.cards.length
        notify player, "You don't even have #{n} cards."
        return
      end
      # Numbers are converted into cards.
      c << player.cards[n-1]
    end
    @discard |= c
    player.delete_cards(c)
    s = if c.length == 1 then '' else 's' end
    say "#{player} discards #{c.length} card#{s}."
    deal(player, player.hand_max - player.cards.length)
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
               :unstoppable => [], :attack => [], :disaster => [],
               :deflector => [], :spare_bolts => [], :toolbox => []
             }
    player.cards.each do |c|
      case c.id
      when :deflector, :dodge, :grab, :insurance, :spare_bolts, :surgery, :toolbox
        c_hash[c.id] << c
      else
        c_hash[c.type] << c
        c_hash[c.type].sort! {|x,y| x.health  <=> y.health }
      end
    end
    c_hash[:support].reverse!
    debug "Created bot's card inventory."
    return c_hash
  end

  def bot_move
    p = players.first
    return unless p.user == @bot.nick
    return if players.length < 2 or p.grabbed
    a = [] # array to pass to play_move
    # For now, just make the bot pick on a random player.
    n = rand(players.length)
    n = rand(players.length) while players[n] == p
    a << players[n].user.to_s
    # Pick the best card to play.
    c_hash = bot_inventory(p)
    card = if c_hash[:deflector].any? or c_hash[:spare_bolts].any?
             c_hash[:deflector].first || c_hash[:spare_bolts].first
           elsif c_hash[:toolbox].any?
             c_hash[:toolbox].first
           elsif p.health == 1 and c_hash[:surgery].any?
             c_hash[:surgery].first
           elsif p.bees and c_hash[:support].any?
             c_hash[:support].first
           elsif c_hash[:grab].any? and c_hash[:unstoppable].any? and c_hash[:attack].any?
             c_hash[:grab].first
           elsif c_hash[:unstoppable].any?
             c_hash[:unstoppable].first
           elsif c_hash[:attack].any?
             c_hash[:attack].first
           elsif p.health < (MAX_HP - 1) and c_hash[:support].any?
             c_hash[:support].first
           elsif c_hash[:disaster].any?
             c_hash[:disaster].first
           else nil
           end
    debug "Bot's cards: " + p.cards.map{ |c| c.id.upcase }.join(', ')
    # Find out which hand card this is,
    # if we have found a suitable card.
    unless card.nil?
      n = 1
      p.cards.each do |c|
        break if c.id == card.id
        n += 1
      end
      a << n
      n2 = rand(p.cards.length)
      if [:crane, :magnet].include? card.id and p.cards.length > 1
        # Throw a random card at the
        # player just for the heck of it!
        n2 = rand(p.cards.length) while n == n2 + 1
        a << n2 + 1
      elsif card.id == :grab
        until p.cards[n2].type == :unstoppable or p.cards[n2].type == :attack
          n2 = rand(p.cards.length)
        end
        a << n2 + 1
      end
    end
    # Play the card or otherwise discard.
    if a.length > 1
      debug "Bot's playing #{a.join(' ')} "
      play_move(a)
    else
      a = Array.new(p.cards.length) { |i| i + 1 }
      # Don't discard the first card
      # in the hand if we can help it.
      a.shift unless a.length < 2
      debug "Bot's discarding #{a.join(' ')}"
      discard(a)
    end
    bot_thread_move if card.type == :disaster
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
    elsif [:crane, :magnet].include? o.discard.id
      card = nil
    elsif p.bees and c_hash[:grab].any? and c_hash[:support].any?
      card = c_hash[:grab].first
      card2 = c_hash[:support].first
    elsif not p.grabbed and c_hash[:dodge].any?
      card = c_hash[:dodge].first
    elsif p.health <= (MAX_HP/2) and c_hash[:counter].any?
      card = c_hash[:counter].first
    elsif p.health <= (MAX_HP/2) and c_hash[:grab].any? and c_hash[:support].any?
      card = c_hash[:grab].first
      card2 = c_hash[:support].first
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
    z = 'cards: '
    p.cards.each { |c| z << "- #{c.id.upcase} " }
    debug z
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
      if p == players.first
        debug "counter-countering with #{a.join(' ')}"
        play_move(a)
      else
        debug "countering with #{a.join(' ')}"
        play_counter(p, a)
      end
    else
      pass(p)
    end
  end

  def bot_thread_counter
    #Thread.new do
      sleep(2)
      bot_counter
    #end
  end

  def bot_thread_move
    #Thread.new do
      sleep(@bot.config['junkyard.bot_delay'])
      bot_move
    #end
  end

  def play_move(a)
    player = players.first
    # Figure out which player is attacking, if anybody.
    if players.length == 2
      # If just two players are playing, the opponent
      # is assumed to be the player not attacking.
      a.delete_at(0) if get_player(a[0], player.user.downcase)
      opponent = players[1]
    else
      if attacked
        opponent = attacked
      else
        # Don't really need an opponent if disaster/support card.
        temp_card = a[0].to_i - 1
        if temp_card.between?(0, player.cards.length-1)
          temp_card = player.cards[temp_card]
          if temp_card.type == :disaster or temp_card.type == :support
            opponent = players[1]
          else
            opponent = get_player(a[0], player.user.downcase)
            if opponent.nil?
              say "There is no player '#{a[0]}'."
              return
            end
            a.delete_at(0)
          end
        else
          opponent = get_player(a[0], player.user.downcase)
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
      c << player.cards[n-1]
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
    elsif c[0].type == :disaster
      do_disaster(player, c[0])
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
    # Don't discard the crane/magnet card.
    if [:crane, :magnet].include? player.discard.id
      player.garbage = c[1..-1]
    end
    player.delete_cards(c[0])
    # Deflector, (by our interpretation of the rules,) automatically
    # pushes the attack onto a person without giving them a chance
    # to respond, therefore we execute the attack and increment_turn.
    deflecting = if opponent.deflector then true else false end
    do_move(player, opponent)
    unless opponent.health < 1 or player.health < 1
      if opponent.grabbed == false and deflecting
        increment_turn
      elsif c[0].type == :support or c[0].type == :unstoppable
        increment_turn
      end
    end
  end

  def play_counter(player, a)
    c = []
    a.delete_at(0) if get_player(a[0], player.user.downcase)
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
    if c[0].type == :disaster
      do_disaster(player, c[0])
      return
    elsif player.discard
      say "You already played a card."
      return
    elsif player != attacked
      notify player, "Wait your turn, #{player.user}."
      return
    end
    do_counter(player, players.first, c)
  end

  def do_grab(player, opponent, c)
    if c[1].nil?
      notify player, "Play an attack when grabbing."
      return
    elsif c[1].type == :counter or c[1].type == :disaster
      notify player, "You can't play a #{c[1].type} card when grabbing."
      return
    elsif c[1].id == :surgery
      dmg = opponent.discard || 0
      unless player.health + dmg <= 1
        notify player, "You can only use that card with 1 health."
        return
      end
    elsif [:crane, :magnet].include? c[1].id
      player.garbage = c[2..-1]
    end
    do_move(opponent, player, wait=false) if player == attacked or opponent.discard
    # In case player dies trying to grab.
    return if player.health < 1
    @discard |= [ c[0], c[1] ]
    player.discard = c[1]
    do_slots(player)
    player.delete_cards([c[0], c[1]])
    # In case player being grabbed dies when
    # when being grabbed (ie., from Deflector).
    if opponent.health < 1
      increment_turn
      return
    end
    @attacked = opponent unless attacked
    opponent.grabbed = true
    say c[0].string % { :p => player, :o => opponent }
    notify opponent, p_cards(opponent)
    bot_thread_counter
  end

  def do_disaster(player, card)
    unless attacked.nil?
      notify player, "You cannot play disaster " +
                     "cards in the middle of an attack."
      return
    end
    # Bees/Deflector are discarded when used up.
    @discard << card unless [:deflector, :the_bees, :propeller].include? card.id
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
      # First player to die from Earthquake is
      # always the player that played the card.
      check_health(player)
      say p_health
      check_health
    when :gas_spill
      victim = players[rand(players.length)]
      victim.skips += card.skips
      say card.string % { :p => player, :o => victim }
    when :propeller
      lucky_victim = players[rand(players.length)]
      lucky_victim.propeller = card
      say card.string % { :p => player, :o => lucky_victim }
    when :reverse
      say card.string % { :p => player }
      # Yank the turn back in two-player games (Uno style).
      if players.length == 2 and player != players.first
        player.turn_wizard += 1
        increment_turn
        return
      elsif players.length > 2
        tmp = @players.reverse
        (tmp.length-1).times do
          tmp << tmp.shift
        end
        @players = tmp
      end
    when :shifty_business
      n = rand(players.length)
      while players[n] == player
        n = rand(players.length)
      end
      say card.string % { :p => player, :o => players[n] }
      player.cards, players[n].cards = players[n].cards, player.cards
      notify(players[n], p_cards(players[n])) unless players[n] == players.first
    when :spare_bolts
      player.go_again = true
      say card.string % { :p => player }
    when :the_bees
      n = rand(players.length)
      players[n].bees = card
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

  def do_move(player, opponent, wait=true, multiplier=1)
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
      opponent.grabbed = false
      @attacked, opponent = players[n], players[n]
      wait = false
    end
    # Let loose the propeller if there is no wait on the attack.
    if multiplier == 1
      if wait and player.discard.type == :attack
        multiplier = 1
      else
        multiplier = propeller(player)
      end
    end
    debug "#{player}'s card is #{player.discard}, " +
          "wait is #{wait}, multiplier is #{multiplier}."
    case player.discard.type
    when :attack
      if wait
        do_slots(player) # Get some new slots while we wait.
        say "#{player} plays #{player.discard}. Respond or pass, #{opponent}."
        notify opponent, p_cards(opponent)
        @attacked = opponent
        bot_thread_counter
        return
      end
      damage = 0
      # Determine amount of damage.
      if player.discard.id == :slot_machine
        string = "#{player} pulls #{opponent}'s lever..."
        slots.each do |slot|
          damage -= slot * multiplier
          string << " #{slot * multiplier}."
        end
        say string
      else
        damage += player.discard.health * multiplier
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
        player.health += player.discard.health * multiplier
      else
        n = player.discard.health * multiplier
        until player.health >= MAX_HP or n < 1
          player.health += 1
          n -= 1
        end
      end
      player.glutton += 1
      bee_recover(player)
    when :unstoppable
      if opponent.discard
        if opponent.discard.type == :counter
          say "#{opponent}'s #{opponent.discard} was thwarted!"
          @discard << opponent.discard
          opponent.discard = nil
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
      when :crane, :magnet
        if player.discard.id == :crane
          opponent.cards |= player.garbage
          deal(player, player.garbage.length * multiplier)
        else
          # Steal opponen't cards, up to double with propeller.
          a = opponent.cards.shuffle.pop(player.garbage.length * multiplier)
          notify player, "#{Bold}You stole:#{Bold} " + a.join(', ')
          player.cards |= a
          opponent.delete_cards(a)
        end
        @discard |= player.garbage
        player.delete_cards(player.garbage)
        player.garbage = nil
        player.sort_cards
      when :meal_steal
        h, temp_deck = player.health, []
        opponent.cards.each do |e|
          if e.id == :soup or e.id == :sub
            temp_deck << e
            h += e.health * multiplier
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
        opponent.health += player.discard.health * multiplier
        player.damage += player.discard.health.abs * multiplier
      end
    end
    # Announce attack
    say player.discard.string % { :p => player, :o => opponent }
    # Tally up turns being missed
    opponent.skips += player.discard.skips * multiplier
    player.turn_wizard += player.discard.skips * multiplier
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
          say "#{player} steals and consumes #{temp_deck.join(', ')}!!"
          bee_recover(player)
        end
      end
      say p_health(player)
    elsif not [:bulldozer, :crane, :magnet].include? player.discard.id
      say p_health(opponent)
      check_health(opponent)
    end
    if opponent.discard
      if opponent.discard.id == :mirror
        say opponent.discard.string %
          { :p => opponent, :o => player, :c => player.discard }
        @discard << opponent.discard
        opponent.discard = player.discard.dup
        player.discard = nil
        # Mirror the attack, passing on any possible multiplier.
        do_move(opponent, player, wait=false, multiplier)
      end
    end
    player.discard = nil
  end

  def do_counter(player, opponent, c)
    unless c[0].type == :counter
      notify player, "Play a counter or pass."
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
        if opponent.propeller
          say "#{player} discards #{player.propeller}."
          @discard << opponent.propeller
          opponent.propeller = nil
        end
        increment_turn
      else
        say "#{player} jumps out of the way and passes " +
            "#{opponent.user}'s attack onto #{players[n]}!"
        @attacked = players[n]
        notify players[n], p_cards(players[n])
        bot_thread_counter
      end
      return
    when :block
      unless opponent.discard.type == :unstoppable
        @discard << c[0]
        player.delete_cards(c[0])
        say c[0].string % { :p => player, :o => opponent,
                            :c => opponent.discard }
        player.blocks += 1 # increment Blocks used
        if opponent.propeller
          say "#{player} discards #{player.propeller}."
          @discard << opponent.propeller
          opponent.propeller = nil
        end
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
    unless player.health < 1 or opponent.health < 1
      if player.discard
        increment_turn unless player.discard.id == :mirror
      else
        increment_turn
      end
    end
  end

  def elapsed_time
    return nil unless started
    return Utils.secs_to_string(Time.now-started)
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
    players.first.turns += 1
    if players.first.go_again
      players.first.go_again = false
    else
      @players << @players.shift
    end
    # Deal the new player some cards.
    player = players.first
    if player.cards.length < player.hand_max
      n = player.hand_max - player.cards.length
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
      player.skip_count += 1
      increment_turn
    else
      say p_turn unless players.length < 2 or not started
      notify player, p_cards(player)
      bot_thread_move
    end
  end

  def next_turn(num=0)
    return 0 if num >= players.length - 1
    return num + 1
  end

  def end_game
    finishing_time = Time.now.to_i - started.to_i
    p = players.first
    b_string = ''
    # Brutality bonus:
    if p.damage >= 30
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
    # Endurance bonus:
    if p.turns >= 20
      p.bonuses += 1
      b = (p.turns/2).to_i
      p.damage += b
      b_string << "Endurance bonus: +#{b}. "
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
    # NOPE bonus:
    if p.blocks >= 7
      p.bonuses += 1
      p.damage += p.blocks
      b_string << "NOPE bonus: +#{p.blocks}. "
    end
    # Speed bonus:
    if finishing_time <= 60
      p.bonuses += 1
      p.damage += 10
      b_string << "Speed bonus: +10. "
    end
    # Turn-Wizard bonus:
    if p.turn_wizard >= 7
      p.bonuses += 1
      p.damage += p.turn_wizard
      b_string << "Turn-Wizard bonus: +#{p.turn_wizard}. "
    end
    # Where's-the-fight? bonus:
    if p.skip_count >= 6
      p.bonuses += 1
      p.damage += p.skip_count * 2
      b_string << "Where's-the-fight? bonus: +#{p.skip_count * 2}. "
    end
    # String revealing winner's remaining cards:
    reveal_string = if @bot.config['junkyard.reveal_cards'] and not p.cards.empty?
                      " -- Cards left: #{p.cards.join(', ')}"
                    else ''
                    end
    say "#{p} wins after #{elapsed_time}, using #{p.turns} turns! " +
        "#{b_string}Damage done: #{p.damage}#{reveal_string}"
    @started = finishing_time # for records
    update_chan_stats(p.damage)
    update_user_stats(p)
    update_records(p)
    @plugin.remove_game(channel)
  end

  def replace_player(player, new_player)
    if player.user == new_player.nick
      say "You're already playing, #{player.user}"
    elsif get_player(new_player.nick)
      say "#{new_player.nick} is already playing #{TITLE}."
    else
      say "#{player} was replaced by #{Bold + new_player.nick + Bold}!"
      player.user = new_player
      say "#{player} is now game manager." if player == manager
    end
  end

  def transfer_management(player, a)
    unless player == manager
      say "#{player.user}: you can't transfer game ownership. " +
          "#{manager} manages this #{title}"
      return
    end
    [ 'game', 'manager', 'management', 'ownership', 'to' ].each do |w|
      a.delete_at(0) if a.first == w
    end
    new_manager = get_player(a.first, manager.user.downcase)
    if new_manager.nil?
      say "'#{a.first}' is not playing #{TITLE}"
      return
    elsif manager == new_manager
      say "#{player.user}: You are already game manager."
      return
    end
    @manager = new_manager
    say "#{new_manager} is now game manager."
  end

  def update_scores?
    unless @bot.config['junkyard.bot_score']
      unless players.length + dropouts.length > 2
        players.each { |p| return false if p.user == @bot.nick }
        dropouts.each { |p| return false if p.user == @bot.nick }
      end
      return false if players.first.user == @bot.nick
    end
    return true
  end

  def update_chan_stats(damage)
    return unless update_scores?
    if @registry.has_key? channel.name
      @registry[channel.name] = [ @registry[channel.name][0] + 1,
                                  @registry[channel.name][1] + damage,
                                  @registry[channel.name][2],
                                  @registry[channel.name][3] || {}
                                ]
    else
      # Registry hierarchy:
      # { #channel1, #channel2, player1, player2, player3, :records }
      #      |                  V                             |-->--|
      #      v  [ nick(proper caps), wins, games, damage, bonuses ] |
      #      |                                                      v
      #      |-> [ games played, accumulated damage,                |
      #            {player stats} {channel-specific records} ]      |
      #             |              V                                v
      #             |    { :most_turns, :least_time,                |
      #             v      :most_time, :most_damage... } <---<---<--|
      #             |
      #             |-> [ nick(proper caps), wins, games, damage, bonuses ]
      #
      @registry[channel.name] = [ 1, damage, {}, {} ]
    end
  end

  def update_records(player)
    return unless update_scores? and @registry.has_key? channel.name
    r1 = @registry[:records] || {}
    r2 = @registry[channel.name][3] || {}
    # Fill in any empty records.
    [ r1, r2 ].each do |r|
      r[:least_time_user] = r[:least_time_user] || player.user.to_s
      r[:least_time] = r[:least_time] || started
      r[:most_time_user] = r[:most_time_user] || player.user.to_s
      r[:most_time] = r[:most_time] || started
      r[:most_damage_user] = r[:most_damage_user] || player.user.to_s
      r[:most_damage] = r[:most_damage] || player.damage
      r[:most_turns_user] = r[:most_turns_user] || player.user.to_s
      r[:most_turns] = r[:most_turns] || player.turns
      if started < r[:least_time]
        r[:least_time_user] = player.user.to_s
        r[:least_time] = started
      elsif started > r[:most_time]
        r[:most_time_user] = player.user.to_s
        r[:most_time] = started
      end
      if player.damage > r[:most_damage]
        r[:most_damage_user] = player.user.to_s
        r[:most_damage] = player.damage
      end
      if player.turns > r[:most_turns]
        r[:most_turns_user] = player.user.to_s
        r[:most_turns] = player.turns
      end
    end
    @registry[:records] = r1
    @registry[channel.name] = [ @registry[channel.name][0],
                                @registry[channel.name][1],
                                @registry[channel.name][2],
                                r2
                              ]
  end

  def update_user_stats(player, win=1)
    return unless update_scores?
    return if @bot.config['junkyard.bot_score'] == false and player.user == @bot.nick
    c = channel.name
    nick = player.user.to_s
    p = player.user.downcase
    @registry[channel.name] = [ 0, 0, {}, {} ] unless @registry.has_key? c
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
    @registry[c] = [ @registry[c][0],
                     @registry[c][1],
                     player_hash,
                     @registry[c][3] || {}
                   ]
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


class JunkyardPlugin < Plugin

  Config.register Config::BooleanValue.new 'junkyard.average_hp',
    :default => false,
    :desc => "Should players joining mid-game receive full health " +
             "or an averaged amount of health from current players?"
  Config.register Config::BooleanValue.new 'junkyard.bot',
    :default => true,
    :desc => "Enables or disables the AI."
  Config.register Config::IntegerValue.new 'junkyard.bot_delay',
    :default => 3,
    :validate => Proc.new{|v| v.between?(0,60)},
    :desc => "Number of seconds for bot to wait before responding."
  Config.register Config::BooleanValue.new 'junkyard.bot_score',
    :default => false,
    :desc => "Record scores for bot and 2-player bot matches."
  Config.register Config::IntegerValue.new 'junkyard.countdown',
    :default => 15,
    :validate => Proc.new{|v| v > 2},
    :desc => "Number of seconds before starting a game of Junkyard."
  Config.register Config::BooleanValue.new 'junkyard.reveal_cards',
    :default => false,
    :desc => "Reveal a player's hand cards when dropped or killed."

  TITLE = Junkyard::TITLE
  MAX_HP = Junkyard::MAX_HP

  attr :games

  def initialize
    super
    @games = {}
  end

  def help(plugin, topic='')
    # Extract help information from CARDS hash.
    id, card = nil, nil
    Junkyard::CARDS.each_pair do |key, value|
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
      color = Junkyard::COLORS[card[:type]]
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
    a = Junkyard::COLORS[:attack]
    c = Junkyard::COLORS[:counter]
    p = Junkyard::COLORS[:disaster]
    s = Junkyard::COLORS[:support]
    u = Junkyard::COLORS[:unstoppable]
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
      "join a game in progress.#{unless @bot.config['junkyard.bot'] then
      ' This feature is currently disabled on this rbot\'s config.'
      else '' end}"
    when /card/
      "#{b}Cards:#{b} Players have 5 cards in their hand. There are 5 types " +
      "of cards: #{a}Attack#{cl} cards are played against other players on " +
      "your turn. #{u}Unstoppable#{cl} cards are as well, but cannot be " +
      "countered by the opponent. #{s}Support#{cl} cards heal you. " +
      "#{c}Counter#{cl} cards counter attacks against you. #{p}Disaster#{cl} " +
      "cards either affect all players or a random player. They do not " +
      "consume a turn. Play these cards at the beginning of anyone's turn. " +
      "Use #{prefix}help #{plugin} <card> for card-specific info."
    when /command/
      "#{b}Commands:#{b} " +
      "c/cards - show cards, " +
      "cd - show current discard, " +
      "d/discard - discard cards, drop <me>/<bot>/<nick> - remove " +
      "yourself/#{@bot.nick}/player from the game, " +
      "pa/pass - pass, " +
      "p/play - play cards, " +
      "replace [with] <nick> - give your spot in game to another player, " +
      "s/score - show score, " +
      "t/turn - show current turn/order/health, " +
      "ti/time - time elapsed since game started"
    when /drop/
      "#{b}Dropping:#{b} Type 'drop' to drop from the game, or 'drop bot' to " +
      "drop the bot from the game. Only the game manager (the player that " +
      "started the game,) can drop other players."
    when /grabbing/
      "#{b}Grabbing:#{b} Although a Counter card, you can Grab other " +
      "players on your own turn. You must lay your intended " +
      "#{a}Attack#{cl}, #{u}Unstoppable#{cl}, or #{s}Support#{cl} card with " +
      "the grab. The attacked player doesn't get to see what card is " +
      "attacking them until they respond with counter or pass. Players " +
      "can't dodge when being grabbed. If the card you played while " +
      "grabbing them turns out to be an #{u}Unstoppable#{cl} attack, any " +
      "counter card they play will be nullified and discarded."
    when /manage/, /transfer/, /xfer/
      "#{b}Manage:#{b} The player that starts the game is the game manager. " +
      "Game managers may stop the game at any time, or transfer ownership " +
      "by typing 'transfer [game to] <player>'."
    when /objective/
      "#{b}Objective:#{b} Every player has #{MAX_HP} health. " +
      "Play cards against an opponent to take away their health. " +
      "Be the last player standing."
    when /play/
      "#{b}Playing:#{b} Type 'p' or 'play' to play a card number from your " +
      "hand. Example: 'p Frank 4' to attack Frank with your 4th card. " +
      "You only need to specify a username when there are more than 2 " +
      "players playing the game."
    when /replace/
      "#{b}Replace:#{b} type 'replace [me with] <nick>' mid-game to " +
      "have another user in the channel take your place in the game."
    when /stat/, 'top'
      "#{b}Stats:#{b} #{prefix}#{plugin} stats <nick> - network-wide stats, " +
      "#{prefix}#{plugin} stats #channel <nick> - channel-specific stats; " +
      "#{prefix}#{plugin} top <num> - top <num> players; " +
      "#{prefix}#{plugin} records <#chan> - special records set, " +
      "#{prefix}#{plugin} records all - network-wide records set."
    when 'stop', /^end/, 'halt'
      "#{prefix}#{plugin} stop - stops the current game of #{TITLE}"
    else
      "#{TITLE} help topics:#{@bot.config['junkyard.bot'] ? ' bot,' : ''} " +
      "commands, play, manage, objective, stats; #{b}Rules:#{b} attacking, " +
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
        m.reply Junkyard::RETORTS.sample % { :p => m.source }
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
               else g.get_player(a[0], m.sourcenick.downcase)
               end
      unless victim
        m.reply "There is no one playing named '#{a[0]}'."
        return
      end
      g.drop_player(victim, p)
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
    when /^(tu?|turn)( |\z)/
      @bot.say m.channel, g.p_order if g.started
    when /^replace( |\z)/
      return if p.nil? or a.length.zero?
      [ "me", "with" ].each { |e| a.delete_at(0) if a.first == e }
      new_player = m.channel.get_user(a.first)
      if new_player.nil?
        m.reply "There is no one here named '#{a.first}'"
      else
        g.replace_player(p, new_player)
      end
    when /^(sc?|scores?)( |\z)/
      @bot.say m.channel, g.p_damage if g.started
    when /^ti(me)?( |\z)/
      if g.started
        m.reply "This game has been going on for #{g.elapsed_time}."
      else
        m.reply TITLE + " hasn't started yet."
      end
    when /^transfer( |\z)/
      return if p.nil? or a.length.zero?
      g.transfer_management(p, a)
    end
  end

  def add_bot(m, plugin)
    unless @bot.config['junkyard.bot']
      m.reply "Playing against #{@bot.nick} is disabled."
      return
    end
    unless @games.key?(m.channel)
      @games[m.channel] = Junkyard.new(self, m.channel, m.source)
    end
    g = @games[m.channel]
    g.add_player(@bot.nick)
  end

  def create_game(m, plugin)
    if @games.key?(m.channel)
      user = @games[m.channel].manager.user
      if m.source.nick == user
        m.reply "...you already started a #{TITLE}"
        return
      else
        m.reply "#{user} already started a #{TITLE}"
        return
      end
    end
    @games[m.channel] = Junkyard.new(self, m.channel, m.source)
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
    manager = @games[m.channel].manager
    player = @games[m.channel].get_player(m.source.nick)
    if manager == player or @bot.auth.irc_to_botuser(m.source).owner?
      remove_game(m.channel)
      @bot.say m.channel, "#{TITLE} stopped."
    else
      m.reply "Only game managers may stop the game."
    end
  end

  def show_records(m, params)
    x = params[:x]
    if m.private? and x.nil?
      m.reply "Specify a channel name or say " +
              "'all' for network-wide records."
      return
    elsif x.nil?
      x = m.channel.name
    elsif x.downcase  == 'all'
      x = :records
    else
      x = '#' + x unless x[0] == '#'
    end
    records = @registry[x] || @registry[x.to_s.downcase]
    if records.class == Array
      records = records[3]
      if records.nil? or records.empty?
        m.reply "No records for #{x} yet."
        return
      else
        @bot.say m.replyto, "#{Bold}Top records for #{x}:"
      end
    elsif records.nil? or records.empty?
      m.reply "No network records set yet."
      return
    else
      @bot.say m.replyto, "#{Bold}Network-wide records:"
    end
    if records[:most_damage]
      @bot.say m.replyto, "Most damage: #{records[:most_damage_user]} " +
                          "with #{records[:most_damage]} damage."
    end
    if records[:most_turns]
      @bot.say m.replyto, "Most turns: #{records[:most_turns_user]} " +
                          "with #{records[:most_turns]} turns."
    end
    if t = records[:least_time]
      @bot.say m.replyto, "Quickest winner: #{records[:least_time_user]} " +
                          "after #{Utils.secs_to_string(t)}."
    end
    if t = records[:most_time]
      @bot.say m.replyto, "Slowest winner: #{records[:most_time_user]} " +
                          "after #{Utils.secs_to_string(t)}."
    end
  end

  def show_stats(m, params)
    if params[:x].nil?
      x = m.source.nick
    elsif params[:x] == false
      x = m.channel.name
    else
      x = params[:x].to_s
    end
    xd = x.downcase
    unless @registry.has_key? xd
      if x =~ /^#/
        m.reply "No one has played #{TITLE} in #{x}."
      elsif x == m.source.nick
        m.reply "You haven't played #{TITLE}"
      elsif x == @bot.nick.downcase and not @bot.config['junkyard.bot_score']
        m.reply "I'm not configured to track my own scores."
      elsif x == @bot.nick.downcase
        m.reply "I haven't played #{TITLE}"
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
        z = params[:z] || 5
        z = if z.to_i.between?(1,10) then z.to_i - 1 else 4 end
        top_players = a[0..z]
        n = 1
        top_players.each do |k|
          @bot.say m.replyto, "#{Bold}#{n}. #{k[:nick]}#{Bold} - " +
                              "#{k[:damage]} dmg (#{k[:wins]}/" +
                              "#{k[:games]} games won)"
          n += 1
          end
        return
      else
        @bot.say m.replyto, "#{Bold}#{@registry[xd][:nick]}#{Bold} -- " +
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
    @bot.say m.replyto, "#{Bold}#{@registry[x][2][y][:nick]}#{Bold} " +
                        "(in #{x}) -- Wins: #{@registry[x][2][y][:wins]}, " +
                        "games: #{@registry[x][2][y][:games]}, " +
                        "damage: #{@registry[x][2][y][:damage]}, " +
                        "special bonuses: #{@registry[x][2][y][:bonuses]}"
  end

end


plugin = JunkyardPlugin.new

[ 'junk', 'junkyard' ].each do |scope|
  plugin.map "#{scope} bot",
    :private => false, :action => :add_bot
  [ 'cancel', 'end', 'halt', 'stop' ].each do |x|
    plugin.map "#{scope} #{x}",
      :private => false, :action => :stop_game
  end
  plugin.map "#{scope} record[s] [:x]",
    :action => :show_records
  plugin.map "#{scope} stat[s] [:x [:y]]",
    :action => :show_stats
  plugin.map "#{scope} top [:z]",
    :private => false, :action => :show_stats,
    :defaults => { :x => false, :z => 5 }
  plugin.map "#{scope}",
    :private => false, :action => :create_game
end

plugin.default_auth('*', true)
