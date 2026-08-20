package com.devops;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class AppHelperTest {
    @Test
    public void testGreeting() {
        assertEquals("DevOps Multi-Language Pipeline Active", AppHelper.getServiceGreeting());
    }
}
