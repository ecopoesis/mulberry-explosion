describe MulberryExplosion do
  context "statistics" do
    let(:capture) do
      capture = MulberryExplosion::DataCapture.new
      capture.add(3)
      capture.add(9)
      capture.add(3)
      capture.add(4)
      capture.add(6)
      capture
    end

    let(:stats) { capture.build_stats }

    context ".less" do
      specify { expect(stats.less(3)).to eq 0 }
      specify { expect(stats.less(4)).to eq 2 }
      specify { expect(stats.less(6)).to eq 3 }
      specify { expect(stats.less(9)).to eq 4 }
    end

    context ".between" do
      specify { expect(stats.between(3, 6)).to eq 4 }
    end

    context ".greater" do
      specify { expect(stats.greater(3)).to eq 3 }
      specify { expect(stats.greater(4)).to eq 2 }
      specify { expect(stats.greater(6)).to eq 1 }
      specify { expect(stats.greater(9)).to eq 0 }
    end
  end
end
