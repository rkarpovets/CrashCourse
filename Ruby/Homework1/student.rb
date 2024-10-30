# frozen_string_literal: true

require 'date'

class Student
  attr_accessor :first_name, :last_name, :date_of_birth

  @@students = []

  def initialize(first_name, last_name, date_of_birth)
    @first_name = first_name
    @last_name = last_name
    @date_of_birth = Date.parse(date_of_birth)

    if self.class.student_exists?(@first_name, @last_name, @date_of_birth)
      raise ArgumentError, 'ERROR: Such a student already exists'
    end

    self.class.add_student(self)
  end

  def self.student_exists?(first_name, last_name, date_of_birth)
    @@students.any? do |student|
      student.first_name == first_name &&
        student.last_name == last_name &&
        student.date_of_birth == date_of_birth
    end
  end

  def calculate_age(date_of_birth)
    validate_date_of_birth(date_of_birth)

    age = Date.today.year - date_of_birth.year

    if Date.today.month < date_of_birth.month ||
       (Date.today.month == date_of_birth.month &&
        Date.today.day < date_of_birth.day)
      age -= 1
    end

    age
  end

  def validate_date_of_birth(date_of_birth)
    raise ArgumentError, 'ERROR: Date of birth must be valid' unless date_of_birth.is_a?(Date)
    raise ArgumentError, 'ERROR: Date of birth cannot be in the future' if date_of_birth > Date.today
  end

  def self.add_student(student)
    @@students << student
  end

  def self.remove_student(student)
    @@students.delete(student)
  end

  def self.all_students
    @@students
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(first_name)
    @@students.select { |student| student.first_name == first_name }
  end
end
