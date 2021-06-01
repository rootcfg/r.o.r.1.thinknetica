require_relative './classes/main'

class Interface
  
  include Logger
  
  MENU = {
    m1: 'Create Station',
    m2: 'Create Train',
    m3: 'Create Route',
    m4: 'Manage Route',
    m5: 'Add wagons to train',
    m6: 'Remove wagons',
    m7: 'All station and trains on them',
    m8: 'Create wagon',
    m9: 'Add route to train',
    m10: 'Exit'
  }.freeze

  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @route = []
  end


  def start_interface
    loop do
      puts ''
      puts '_______________________________________________________________________'.blue
      puts 'Please, select action, or "0" for exit'.blue
      MENU.each do |k, v|
        puts "#{k}  #{v}"
      end
      puts '_______________________________________________________________________'.blue
      puts ''

      choise = gets.chomp!.to_sym
      if choise == :m0
        puts 'Good luck!'
        exit
      end

      case choise
      when  :m1
        create_station
        redo
      when  :m2
        create_train
        redo
      when  :m3
        create_route
        redo
      when  :m4
        manage_route
        redo
      when  :m5
        add_wagons_to_train
        redo
      when  :m6
        remove_wagon
        redo
      when  :m7
        all_station_with_trains
        redo
      when :m8
        create_wagon
        redo
      when :m9
        add_route_to_train
      when :m10
        puts "Goodluck! Comeback again!"
        exit
      else
        puts 'Your choise is incorrect! Try again!'
        redo
      end
    end
  end

  private

  def all_station_with_trains
    @stations.each do |st|
      puts "* #{st.name}"
        st.trains.each { |train| puts train.name.to_s + ' ' + train.type.to_s + ' ' + train.wagons.size }
    end
  end

  def create_station
    print 'Please enter the station name: '.blue
    station = gets.chomp!
    begin
      st = Station.new(station)
      @stations << st
      puts "Station #{st.name.yellow} successfully created!".green
      log("Station #{st.name} was created", "#{self.class}")
    rescue StandardError => e
      puts e.message
    end
  end

  def create_train
    print 'What kind of train you want? Passenger Train(m1) or Cargo Train(m2) ? '.blue
    type = gets.chomp!.to_sym
    print 'Please, enter the train name: '.blue
    name = gets.chomp!
    begin
      if type == :m1
        train = PassengerTrain.new(name)
        @trains << train
        puts "Train #{train.name} successfully created!".green
      elsif type == :m2
        train = CargoTrain.new(name)
        @trains << train
        puts "Train #{train.name} successfully created!".green
      end
    rescue StandardError => e
      puts e.message
    end
  end

  def create_route
    begin
      if @stations.size < 2
        puts 'You need create more than one station. Route must have start and final station!'.red
      else
        puts 'Stations list:'.blue
        @stations.each_with_index do |station, index|
          puts " #{station.name} : #{index} "
          station.trains.each { |train| puts train.name.to_s }
        end
        print 'Please choise start station. Example: (1)'.blue
        start_station = gets.chomp!.to_i
        print 'Please choise final station. Example: (5)'.blue
        final_station = gets.chomp!.to_i
        @route << Route.new(@stations[start_station], @stations[final_station])
        print 'New route successfully created'.green
      end
    rescue StandardError => e
      puts e.message
    end
  end

  def all_station_with_trains
    @stations.each do |st|
      puts "* #{st.name}"
      st.trains.each { |train| puts train.name.to_s }
    end
  end

  def manage_route
    begin
      if @route.empty?
        puts 'Please create route!'.red
      else
        @route.each_with_index do |val, index|
          puts "* #{index} : #{val.name}"
        end
        puts 'Please select action:'.blue
        puts 'm1. delete station'.red
        puts 'm2. add station'.blue
        choise = gets.chomp!.to_sym
        if choise == :m1
          puts 'select station for deletion: '.blue
          @route[0].stations
          station_for_deletion = gets.chomp!.to_sym
          puts 'Current station deleted successfully'.green if @route[0].remove_station(station_for_deletion)
        elsif choise == :m2
          puts 'Please choose station for include'.blue
          @stations.each_with_index do |st, index|
            puts "#{index}.   #{st.name}" unless @route.include?(@stations[index])
          end
          st_to_add = gets.chomp!.to_i
          if @route.include?(@stations[st_to_add])
            puts 'This station is already included, please choose anather one!'.red
          else
            @route << @stations[st_to_add]
            puts 'New station added to route successfully'.green
          end
        end
      end
    rescue StandardError => e
      puts e.message
    end
  end

  def create_wagon
    print 'What kind of wagon you want? Passenger wagon (m1) or Cargo wagon (m2) ? '.blue
    type = gets.chomp!.to_sym
    print 'Please, enter the wagon name \ number: '.blue
    name = gets.chomp!
    begin
      if type == :m1
        wagon = PassangerWagon.new(name)
        @wagons << wagon
      elsif type == :m2
        wagon = CargoWagon.new(name)
        @wagons << wagon
      end
    rescue StandardError => e
      puts e.message
    else
      puts "Wagon #{wagon.number} successfully created!".green
    end
  end

  def add_wagons_to_train
    puts 'Please choose train:'.blue
    if @trains.empty?
      puts 'No one train was found! Please create some one!'.red
    else
      puts "Choose train type: Passenger (m1) \ Cargo (m2) ".blue
      train_type = gets.chomp!.to_sym
      if train = show_trains_list(train_type)
        if wag = select_wagon(train_type)
          train.wagons << wag
          puts 'New wagon added'.green
        end
      end
    end
  end

  def show_trains_list(trains)
    train_type = trains.to_sym == :m1 ? @trains.select { |train| train.instance_of? PassengerTrain } : @trains.select { |train| train.instance_of? CargoTrain }
    train_type.each_with_index { |train, index| puts "#{index}: #{train.number}" }
    puts 'Choose the train: '.blue
    train = gets.chomp!.to_i
    train_type[train]
  end

  def select_wagon(wagons)
    wagon_type = wagons == :m1 ? @wagons.select { |wagon| wagon.instance_of? PassangerWagon } : @wagons.select { |wagon| wagon.instance_of? == CargoWagon }
    puts wagons.inspect
    puts @wagons.inspect
    puts wagon_type.inspect
    puts 'Please select wagon'.blue
    wagon_type.each_with_index { |wagon, index| puts "#{index} : #{wagon.number}" }
    wagon = gets.chomp!.to_i
    wagon_type[wagon] if wagon_type.include?(wagon_type[wagon])
  end

  def remove_wagon
    puts 'Select wagon type: m1. Passenger m2. Cargo '.blue
    type = gets.chomp!
    wagon = select_wagon(type)
    if wagon.instance_of?(PassangerWagon)
      @passenger_wagons.delete(wagon)
      puts 'wagon deleted'.green
    elsif  wagon.instance_of?(CargoWagon)
      @cargo_wagons.delete(wagon)
      puts 'wagon deleted'.green
    end
  end

  def add_route_to_train
    print 'What kind of train you want? Passenger Train(m1) or Cargo Train(m2) ? '.blue
    train_type = gets.chomp!
    train = show_trains_list(train_type)
    puts 'Please select the route'
    @route.each_with_index { |route, index| puts "#{index} : #{route}" }
    route = gets.chomp!
    route = @route[route.to_i]
    train.make_route route
  end

  def move_train_forward
    print 'What kind of train you want? Passenger Train(m1) or Cargo Train(m2) ? '.blue
    train_type = gets.chomp!
    puts "Train move to #{show_trains_list(train_type).nex_station}" if show_trains_list(train_type).forward_movement
  end
end

interface = Interface.new
interface.start_interface