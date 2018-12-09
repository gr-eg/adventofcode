#!/usr/bin/env ruby
require 'date'
require 'byebug'

class Event
  attr_reader :date, :name
  GUARD_REGEXP = /Guard #(\d+) begins shift/

  def initialize(date, name)
    @date = DateTime.parse(date)
    @name = name
  end

  def inspect
    "[#{@date.strftime('%Y-%m-%d %H:%M')}] #{@name}"
  end

  def guard?
    name.match?(GUARD_REGEXP)
  end

  def guard_id
    return nil unless guard?
    name.match(GUARD_REGEXP)[1]
  end
end

class Guard
  attr_accessor :id, :events
  def initialize(id)
    @id = id
    @events = []
  end

  def add_event(event)
    @events << event
  end

  def asleep_duration
    asleep_durations.map(&:count).sum
  end

  def sleepiest_minute
    asleep_durations.flatten.max_by { |i| asleep_durations.flatten.count(i) }
  end

  def minute_occurences
    foo = asleep_durations.flatten.group_by(&:itself).max_by { |k, v| v.count }
    foo ? foo[1].count : 0
  end

  def inspect
    "ID: #{@id}, Duration: #{asleep_duration}, Sleepiest: #{sleepiest_minute}, occ: #{minute_occurences}"
  end

  private

  def asleep_durations
    @events.each_slice(2).map { |a| (a[0].date.minute...a[1].date.minute).to_a }
  end
end

class Parser
  EVENT_REGEXP = /\[(?<date>\d{4}-\d{2}-\d{2}\s\d{2}:\d{2})\]\s(?<event>.+)/.freeze

  def initialize(events)
    @events = events
              .map { |x| Event.new(*x.chomp.match(EVENT_REGEXP).captures) }
              # .sort_by(&:date)
    @events = @events
    @guards = {}
  end

  def parse
    until @events.empty?
      event = @events.shift
      if event && event.guard?
        guard = @guards[event.guard_id] || Guard.new(event.guard_id)
        while @events.first && !@events.first.guard?
          guard.add_event(@events.shift)
        end
        @guards[event.guard_id] = guard
      end
    end
    @guards.values
  end
end

lines = File.readlines('input.txt').sort
guards = Parser.new(lines).parse

sleepiest_guard = guards.max_by { |x| x.asleep_duration }
puts "Part 1: #{sleepiest_guard.id.to_i * sleepiest_guard.sleepiest_minute.to_i}"
consistently_sleepy = guards.max_by { |x| x.minute_occurences }

puts "Part 2: #{consistently_sleepy.id.to_i * consistently_sleepy.sleepiest_minute.to_i}"
