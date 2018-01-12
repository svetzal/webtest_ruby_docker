describe "Google" do
    it "should load" do
        visit("/")
        page.save_screenshot('screenshots/google.png');
        expect(true).to be
    end
end
