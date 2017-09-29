require 'student'
require 'date'

class FakeTest
  def initialize(date_taken, answers)
    @date_taken = date_taken
    @answers    = answers
  end

  def pretty_date_taken
    @date_taken.to_s
  end

  def score
    @answers.count { |answer| answer.correct? }
  end
end

class FakeFeedback
  attr_reader :happiness

  def initialize(happiness, day_submitted)
    @happiness     = happiness
    @day_submitted = day_submitted
  end
end

class FakeAnswer
  def initialize(answer_given, correct_answer)
    @answer_given   = answer_given
    @correct_answer = correct_answer
  end

  def correct?
    @answer_given == @correct_answer
  end
end

describe Student do
  subject(:student) { Student.new }

  describe '#full_name' do
    it 'returns the student first name and last name' do
      student = Student.new(first_name: "Sian", last_name: "McAvoy")

      expect(student.full_name).to eq "Sian McAvoy"
    end

    it 'defaults to "Joe Bloggs"' do
      expect(student.full_name).to eq "Joe Bloggs"
    end
  end

  describe '#happiness' do
    it 'returns the average happiness reported' do
      feedback_1 = FakeFeedback.new(4, Date.today)
      feedback_2 = FakeFeedback.new(4, Date.today)
      student = Student.new(feedbacks: [feedback_1, feedback_2])

      expect(student.happiness).to eq 4
    end

    it 'defaults to zero' do
      expect(student.happiness).to eq 0
    end
  end

  describe '#test_scores' do
    it 'returns all test scores' do
      test_1 = FakeTest.new(Date.today, [FakeAnswer.new(5, 5)])
      test_2 = FakeTest.new(Date.today, [FakeAnswer.new(6, 6)])
      student = Student.new(tests: [test_1, test_2])

      expect(student.test_scores).to eq({ "#{ Date.today.to_s }" => [1, 1] })
    end

    it 'defaults to being empty' do
      expect(student.test_scores).to be_empty
    end
  end

  describe '#attendance' do
    it 'describes the student attendance' do
    end
  end
end
