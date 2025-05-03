using Moq;

namespace TestProject1
{
    public class UnitTest1
    {
        [Fact]
        public void Test_Greet_ReturnsExpectedValue()
        {
            // Arrange
            var mockService = new Mock<IGreetingService>();
            mockService.Setup(s => s.Greet("Alice")).Returns("Hello, Alice");

            // Act
            var result = mockService.Object.Greet("Alice");

            // Assert
            Assert.Equal("Hello, Alice", result);
            mockService.Verify(s => s.Greet("Alice"), Times.Once);
        }
    }

    // Dummy interface to simulate the real one (in actual code, import it)
    public interface IGreetingService
    {
        string Greet(string name);
    }
}