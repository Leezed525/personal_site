
import com.ruoyi.RuoYiApplication;
import com.ruoyi.lee.scheduler.ViewScheduler;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = RuoYiApplication.class)
public class ViewSchedulerTest {

    @Autowired(required = false)
    private ViewScheduler viewScheduler;

    @Test
    public void testExecuteRecordView() {
        // 调用方法
        viewScheduler.executeRecordView();
    }
}