# Makefile

SCRIPTS_DIR := $(PWD)/scripts
TEST_ALERT_SCRIPT := $(SCRIPTS_DIR)/test_alert.sh

.PHONY: alert resolve

alert:
	$(TEST_ALERT_SCRIPT) fire

resolve:
	$(TEST_ALERT_SCRIPT) resolve
