--
-- PostgreSQL database dump
--

\restrict psMUOaz2bPktr0EtyrIfEVOZCuWSPs8ai9iLvfy6bFofAS3l4bolDakNuD2oCGi

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.working_hours DROP CONSTRAINT IF EXISTS working_hours_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.workflow_steps DROP CONSTRAINT IF EXISTS workflow_steps_workflow_id_fkey;
ALTER TABLE IF EXISTS ONLY public.work_orders DROP CONSTRAINT IF EXISTS work_orders_service_id_fkey;
ALTER TABLE IF EXISTS ONLY public.work_orders DROP CONSTRAINT IF EXISTS work_orders_quotation_id_fkey;
ALTER TABLE IF EXISTS ONLY public.work_orders DROP CONSTRAINT IF EXISTS work_orders_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.work_orders DROP CONSTRAINT IF EXISTS work_orders_assigned_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.webhook_logs DROP CONSTRAINT IF EXISTS webhook_logs_webhook_id_fkey;
ALTER TABLE IF EXISTS ONLY public.warranty_claims DROP CONSTRAINT IF EXISTS warranty_claims_warranty_id_fkey;
ALTER TABLE IF EXISTS ONLY public.versions DROP CONSTRAINT IF EXISTS versions_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.vehicle_stock DROP CONSTRAINT IF EXISTS vehicle_stock_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.vehicle_stock DROP CONSTRAINT IF EXISTS vehicle_stock_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.vehicle_expenses DROP CONSTRAINT IF EXISTS vehicle_expenses_vehicle_id_fkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_role_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_sessions DROP CONSTRAINT IF EXISTS user_sessions_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_preferences DROP CONSTRAINT IF EXISTS user_preferences_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_dashboard_widgets DROP CONSTRAINT IF EXISTS user_dashboard_widgets_widget_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_dashboard_widgets DROP CONSTRAINT IF EXISTS user_dashboard_widgets_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.two_factor_auth DROP CONSTRAINT IF EXISTS two_factor_auth_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.transfers DROP CONSTRAINT IF EXISTS transfers_to_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.transfers DROP CONSTRAINT IF EXISTS transfers_from_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.transfers DROP CONSTRAINT IF EXISTS transfers_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.time_off_requests DROP CONSTRAINT IF EXISTS time_off_requests_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.time_off_requests DROP CONSTRAINT IF EXISTS time_off_requests_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY public.territories DROP CONSTRAINT IF EXISTS territories_parent_territory_id_fkey;
ALTER TABLE IF EXISTS ONLY public.territories DROP CONSTRAINT IF EXISTS territories_manager_id_fkey;
ALTER TABLE IF EXISTS ONLY public.technicians DROP CONSTRAINT IF EXISTS technicians_vehicle_id_fkey;
ALTER TABLE IF EXISTS ONLY public.technicians DROP CONSTRAINT IF EXISTS technicians_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.technician_trainings DROP CONSTRAINT IF EXISTS technician_trainings_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.technician_trainings DROP CONSTRAINT IF EXISTS technician_trainings_program_id_fkey;
ALTER TABLE IF EXISTS ONLY public.technician_skill_assignments DROP CONSTRAINT IF EXISTS technician_skill_assignments_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.technician_skill_assignments DROP CONSTRAINT IF EXISTS technician_skill_assignments_skill_id_fkey;
ALTER TABLE IF EXISTS ONLY public.technician_reviews DROP CONSTRAINT IF EXISTS technician_reviews_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.technician_reviews DROP CONSTRAINT IF EXISTS technician_reviews_service_id_fkey;
ALTER TABLE IF EXISTS ONLY public.technician_reviews DROP CONSTRAINT IF EXISTS technician_reviews_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.technician_performance DROP CONSTRAINT IF EXISTS technician_performance_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.technician_locations DROP CONSTRAINT IF EXISTS technician_locations_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.tasks DROP CONSTRAINT IF EXISTS tasks_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.tasks DROP CONSTRAINT IF EXISTS tasks_assigned_to_fkey;
ALTER TABLE IF EXISTS ONLY public.system_settings DROP CONSTRAINT IF EXISTS system_settings_updated_by_fkey;
ALTER TABLE IF EXISTS ONLY public.survey_responses DROP CONSTRAINT IF EXISTS survey_responses_survey_id_fkey;
ALTER TABLE IF EXISTS ONLY public.survey_responses DROP CONSTRAINT IF EXISTS survey_responses_service_id_fkey;
ALTER TABLE IF EXISTS ONLY public.survey_responses DROP CONSTRAINT IF EXISTS survey_responses_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.survey_questions DROP CONSTRAINT IF EXISTS survey_questions_survey_id_fkey;
ALTER TABLE IF EXISTS ONLY public.survey_answers DROP CONSTRAINT IF EXISTS survey_answers_response_id_fkey;
ALTER TABLE IF EXISTS ONLY public.survey_answers DROP CONSTRAINT IF EXISTS survey_answers_question_id_fkey;
ALTER TABLE IF EXISTS ONLY public.stock_movements DROP CONSTRAINT IF EXISTS stock_movements_warehouse_id_fkey;
ALTER TABLE IF EXISTS ONLY public.stock_movements DROP CONSTRAINT IF EXISTS stock_movements_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.stock_movements DROP CONSTRAINT IF EXISTS stock_movements_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.stock_counts DROP CONSTRAINT IF EXISTS stock_counts_warehouse_id_fkey;
ALTER TABLE IF EXISTS ONLY public.stock_counts DROP CONSTRAINT IF EXISTS stock_counts_counted_by_fkey;
ALTER TABLE IF EXISTS ONLY public.stock_count_items DROP CONSTRAINT IF EXISTS stock_count_items_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.stock_count_items DROP CONSTRAINT IF EXISTS stock_count_items_count_id_fkey;
ALTER TABLE IF EXISTS ONLY public.services DROP CONSTRAINT IF EXISTS services_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.services DROP CONSTRAINT IF EXISTS services_invoice_id_fkey;
ALTER TABLE IF EXISTS ONLY public.services DROP CONSTRAINT IF EXISTS services_device_id_fkey;
ALTER TABLE IF EXISTS ONLY public.services DROP CONSTRAINT IF EXISTS services_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.services DROP CONSTRAINT IF EXISTS services_appointment_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_zones DROP CONSTRAINT IF EXISTS service_zones_default_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_ratings DROP CONSTRAINT IF EXISTS service_ratings_service_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_photos DROP CONSTRAINT IF EXISTS service_photos_taken_by_fkey;
ALTER TABLE IF EXISTS ONLY public.service_photos DROP CONSTRAINT IF EXISTS service_photos_service_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_photos DROP CONSTRAINT IF EXISTS service_photos_file_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_parts DROP CONSTRAINT IF EXISTS service_parts_service_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_parts DROP CONSTRAINT IF EXISTS service_parts_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_checklists DROP CONSTRAINT IF EXISTS service_checklists_template_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_checklists DROP CONSTRAINT IF EXISTS service_checklists_service_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_checklist_responses DROP CONSTRAINT IF EXISTS service_checklist_responses_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_checklist_responses DROP CONSTRAINT IF EXISTS service_checklist_responses_checklist_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_checklist_items DROP CONSTRAINT IF EXISTS service_checklist_items_template_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_areas DROP CONSTRAINT IF EXISTS service_areas_assigned_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.service_area_pricing DROP CONSTRAINT IF EXISTS service_area_pricing_area_id_fkey;
ALTER TABLE IF EXISTS ONLY public.scheduled_maintenance_history DROP CONSTRAINT IF EXISTS scheduled_maintenance_history_schedule_id_fkey;
ALTER TABLE IF EXISTS ONLY public.scheduled_maintenance_history DROP CONSTRAINT IF EXISTS scheduled_maintenance_history_appointment_id_fkey;
ALTER TABLE IF EXISTS ONLY public.saved_filters DROP CONSTRAINT IF EXISTS saved_filters_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.salaries DROP CONSTRAINT IF EXISTS salaries_employee_id_fkey;
ALTER TABLE IF EXISTS ONLY public.salaries DROP CONSTRAINT IF EXISTS salaries_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.routes DROP CONSTRAINT IF EXISTS routes_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.route_stops DROP CONSTRAINT IF EXISTS route_stops_route_id_fkey;
ALTER TABLE IF EXISTS ONLY public.route_stops DROP CONSTRAINT IF EXISTS route_stops_appointment_id_fkey;
ALTER TABLE IF EXISTS ONLY public.role_permissions DROP CONSTRAINT IF EXISTS role_permissions_role_id_fkey;
ALTER TABLE IF EXISTS ONLY public.role_permissions DROP CONSTRAINT IF EXISTS role_permissions_permission_id_fkey;
ALTER TABLE IF EXISTS ONLY public.return_requests DROP CONSTRAINT IF EXISTS return_requests_invoice_id_fkey;
ALTER TABLE IF EXISTS ONLY public.return_requests DROP CONSTRAINT IF EXISTS return_requests_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.return_requests DROP CONSTRAINT IF EXISTS return_requests_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY public.return_request_items DROP CONSTRAINT IF EXISTS return_request_items_return_id_fkey;
ALTER TABLE IF EXISTS ONLY public.return_request_items DROP CONSTRAINT IF EXISTS return_request_items_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.report_schedules DROP CONSTRAINT IF EXISTS report_schedules_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.referrals DROP CONSTRAINT IF EXISTS referrals_referrer_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.referrals DROP CONSTRAINT IF EXISTS referrals_referred_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.recurring_invoices DROP CONSTRAINT IF EXISTS recurring_invoices_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.recurring_invoices DROP CONSTRAINT IF EXISTS recurring_invoices_contract_id_fkey;
ALTER TABLE IF EXISTS ONLY public.quotations DROP CONSTRAINT IF EXISTS quotations_device_id_fkey;
ALTER TABLE IF EXISTS ONLY public.quotations DROP CONSTRAINT IF EXISTS quotations_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.quotations DROP CONSTRAINT IF EXISTS quotations_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.quotations DROP CONSTRAINT IF EXISTS quotations_converted_to_invoice_id_fkey;
ALTER TABLE IF EXISTS ONLY public.quotation_items DROP CONSTRAINT IF EXISTS quotation_items_quotation_id_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase_orders DROP CONSTRAINT IF EXISTS purchase_orders_supplier_id_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase_orders DROP CONSTRAINT IF EXISTS purchase_orders_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase_order_items DROP CONSTRAINT IF EXISTS purchase_order_items_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase_order_items DROP CONSTRAINT IF EXISTS purchase_order_items_order_id_fkey;
ALTER TABLE IF EXISTS ONLY public.promissory_notes DROP CONSTRAINT IF EXISTS promissory_notes_supplier_id_fkey;
ALTER TABLE IF EXISTS ONLY public.promissory_notes DROP CONSTRAINT IF EXISTS promissory_notes_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.price_list_items DROP CONSTRAINT IF EXISTS price_list_items_price_list_id_fkey;
ALTER TABLE IF EXISTS ONLY public.price_list_items DROP CONSTRAINT IF EXISTS price_list_items_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.price_history DROP CONSTRAINT IF EXISTS price_history_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.price_history DROP CONSTRAINT IF EXISTS price_history_changed_by_fkey;
ALTER TABLE IF EXISTS ONLY public.petty_cash DROP CONSTRAINT IF EXISTS petty_cash_handled_by_fkey;
ALTER TABLE IF EXISTS ONLY public.petty_cash DROP CONSTRAINT IF EXISTS petty_cash_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY public.payments_received DROP CONSTRAINT IF EXISTS payments_received_invoice_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payments_received DROP CONSTRAINT IF EXISTS payments_received_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payments_received DROP CONSTRAINT IF EXISTS payments_received_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.payments_received DROP CONSTRAINT IF EXISTS payments_received_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payment_plans DROP CONSTRAINT IF EXISTS payment_plans_service_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payment_plans DROP CONSTRAINT IF EXISTS payment_plans_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payment_plan_installments DROP CONSTRAINT IF EXISTS payment_plan_installments_plan_id_fkey;
ALTER TABLE IF EXISTS ONLY public.password_resets DROP CONSTRAINT IF EXISTS password_resets_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.parts DROP CONSTRAINT IF EXISTS parts_supplier_id_fkey;
ALTER TABLE IF EXISTS ONLY public.partner_transactions DROP CONSTRAINT IF EXISTS partner_transactions_partner_id_fkey;
ALTER TABLE IF EXISTS ONLY public.partner_transactions DROP CONSTRAINT IF EXISTS partner_transactions_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY public.partner_transactions DROP CONSTRAINT IF EXISTS partner_transactions_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.partner_current_accounts DROP CONSTRAINT IF EXISTS partner_current_accounts_partner_id_fkey;
ALTER TABLE IF EXISTS ONLY public.part_suppliers DROP CONSTRAINT IF EXISTS part_suppliers_supplier_id_fkey;
ALTER TABLE IF EXISTS ONLY public.part_suppliers DROP CONSTRAINT IF EXISTS part_suppliers_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.part_returns DROP CONSTRAINT IF EXISTS part_returns_service_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.part_returns DROP CONSTRAINT IF EXISTS part_returns_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.part_photos DROP CONSTRAINT IF EXISTS part_photos_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.part_photos DROP CONSTRAINT IF EXISTS part_photos_file_id_fkey;
ALTER TABLE IF EXISTS ONLY public.overtime DROP CONSTRAINT IF EXISTS overtime_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.overtime DROP CONSTRAINT IF EXISTS overtime_employee_id_fkey;
ALTER TABLE IF EXISTS ONLY public.overtime DROP CONSTRAINT IF EXISTS overtime_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.notification_preferences DROP CONSTRAINT IF EXISTS notification_preferences_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.marketing_messages DROP CONSTRAINT IF EXISTS marketing_messages_campaign_id_fkey;
ALTER TABLE IF EXISTS ONLY public.maintenance_schedules DROP CONSTRAINT IF EXISTS maintenance_schedules_device_id_fkey;
ALTER TABLE IF EXISTS ONLY public.licenses DROP CONSTRAINT IF EXISTS licenses_file_id_fkey;
ALTER TABLE IF EXISTS ONLY public.leaves DROP CONSTRAINT IF EXISTS leaves_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.leaves DROP CONSTRAINT IF EXISTS leaves_employee_id_fkey;
ALTER TABLE IF EXISTS ONLY public.leaves DROP CONSTRAINT IF EXISTS leaves_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY public.ip_whitelist DROP CONSTRAINT IF EXISTS ip_whitelist_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.invoices DROP CONSTRAINT IF EXISTS invoices_service_id_fkey;
ALTER TABLE IF EXISTS ONLY public.invoices DROP CONSTRAINT IF EXISTS invoices_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.invoices DROP CONSTRAINT IF EXISTS invoices_bank_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.invoice_items DROP CONSTRAINT IF EXISTS invoice_items_invoice_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inventory_adjustments DROP CONSTRAINT IF EXISTS inventory_adjustments_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.inventory_adjustments DROP CONSTRAINT IF EXISTS inventory_adjustments_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY public.inventory_adjustment_items DROP CONSTRAINT IF EXISTS inventory_adjustment_items_warehouse_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inventory_adjustment_items DROP CONSTRAINT IF EXISTS inventory_adjustment_items_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inventory_adjustment_items DROP CONSTRAINT IF EXISTS inventory_adjustment_items_adjustment_id_fkey;
ALTER TABLE IF EXISTS ONLY public.internal_messages DROP CONSTRAINT IF EXISTS internal_messages_sender_id_fkey;
ALTER TABLE IF EXISTS ONLY public.internal_messages DROP CONSTRAINT IF EXISTS internal_messages_recipient_id_fkey;
ALTER TABLE IF EXISTS ONLY public.internal_messages DROP CONSTRAINT IF EXISTS internal_messages_parent_message_id_fkey;
ALTER TABLE IF EXISTS ONLY public.insurance_policies DROP CONSTRAINT IF EXISTS insurance_policies_file_id_fkey;
ALTER TABLE IF EXISTS ONLY public.installments DROP CONSTRAINT IF EXISTS installments_plan_id_fkey;
ALTER TABLE IF EXISTS ONLY public.installment_plans DROP CONSTRAINT IF EXISTS installment_plans_invoice_id_fkey;
ALTER TABLE IF EXISTS ONLY public.vehicles DROP CONSTRAINT IF EXISTS fk_vehicle_technician;
ALTER TABLE IF EXISTS ONLY public.files DROP CONSTRAINT IF EXISTS files_uploaded_by_fkey;
ALTER TABLE IF EXISTS ONLY public.expenses DROP CONSTRAINT IF EXISTS expenses_supplier_id_fkey;
ALTER TABLE IF EXISTS ONLY public.expenses DROP CONSTRAINT IF EXISTS expenses_expense_category_id_fkey;
ALTER TABLE IF EXISTS ONLY public.expenses DROP CONSTRAINT IF EXISTS expenses_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.expenses DROP CONSTRAINT IF EXISTS expenses_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY public.expenses DROP CONSTRAINT IF EXISTS expenses_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.expense_categories DROP CONSTRAINT IF EXISTS expense_categories_parent_category_id_fkey;
ALTER TABLE IF EXISTS ONLY public.entity_tags DROP CONSTRAINT IF EXISTS entity_tags_tag_id_fkey;
ALTER TABLE IF EXISTS ONLY public.employees DROP CONSTRAINT IF EXISTS employees_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.employee_shifts DROP CONSTRAINT IF EXISTS employee_shifts_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.employee_shifts DROP CONSTRAINT IF EXISTS employee_shifts_schedule_id_fkey;
ALTER TABLE IF EXISTS ONLY public.employee_shifts DROP CONSTRAINT IF EXISTS employee_shifts_employee_id_fkey;
ALTER TABLE IF EXISTS ONLY public.employee_documents DROP CONSTRAINT IF EXISTS employee_documents_file_id_fkey;
ALTER TABLE IF EXISTS ONLY public.employee_documents DROP CONSTRAINT IF EXISTS employee_documents_employee_id_fkey;
ALTER TABLE IF EXISTS ONLY public.emergency_contacts DROP CONSTRAINT IF EXISTS emergency_contacts_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.emergency_contacts DROP CONSTRAINT IF EXISTS emergency_contacts_employee_id_fkey;
ALTER TABLE IF EXISTS ONLY public.documents DROP CONSTRAINT IF EXISTS documents_file_id_fkey;
ALTER TABLE IF EXISTS ONLY public.document_photos DROP CONSTRAINT IF EXISTS document_photos_scanned_by_fkey;
ALTER TABLE IF EXISTS ONLY public.document_photos DROP CONSTRAINT IF EXISTS document_photos_file_id_fkey;
ALTER TABLE IF EXISTS ONLY public.discount_codes DROP CONSTRAINT IF EXISTS discount_codes_campaign_id_fkey;
ALTER TABLE IF EXISTS ONLY public.devices DROP CONSTRAINT IF EXISTS devices_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.device_parts DROP CONSTRAINT IF EXISTS device_parts_part_id_fkey;
ALTER TABLE IF EXISTS ONLY public.device_parts DROP CONSTRAINT IF EXISTS device_parts_installed_by_fkey;
ALTER TABLE IF EXISTS ONLY public.device_parts DROP CONSTRAINT IF EXISTS device_parts_device_id_fkey;
ALTER TABLE IF EXISTS ONLY public.device_history DROP CONSTRAINT IF EXISTS device_history_device_id_fkey;
ALTER TABLE IF EXISTS ONLY public.device_documents DROP CONSTRAINT IF EXISTS device_documents_file_id_fkey;
ALTER TABLE IF EXISTS ONLY public.device_documents DROP CONSTRAINT IF EXISTS device_documents_device_id_fkey;
ALTER TABLE IF EXISTS ONLY public.depreciation DROP CONSTRAINT IF EXISTS depreciation_asset_id_fkey;
ALTER TABLE IF EXISTS ONLY public.debit_notes DROP CONSTRAINT IF EXISTS debit_notes_invoice_id_fkey;
ALTER TABLE IF EXISTS ONLY public.debit_notes DROP CONSTRAINT IF EXISTS debit_notes_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.debit_notes DROP CONSTRAINT IF EXISTS debit_notes_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.data_exports DROP CONSTRAINT IF EXISTS data_exports_requested_by_fkey;
ALTER TABLE IF EXISTS ONLY public.customers DROP CONSTRAINT IF EXISTS customers_assigned_sales_rep_fkey;
ALTER TABLE IF EXISTS ONLY public.customer_preferences DROP CONSTRAINT IF EXISTS customer_preferences_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.customer_notes DROP CONSTRAINT IF EXISTS customer_notes_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.customer_notes DROP CONSTRAINT IF EXISTS customer_notes_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.customer_contacts DROP CONSTRAINT IF EXISTS customer_contacts_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.customer_addresses DROP CONSTRAINT IF EXISTS customer_addresses_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.current_account_transactions DROP CONSTRAINT IF EXISTS current_account_transactions_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.credit_notes DROP CONSTRAINT IF EXISTS credit_notes_invoice_id_fkey;
ALTER TABLE IF EXISTS ONLY public.credit_notes DROP CONSTRAINT IF EXISTS credit_notes_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.credit_notes DROP CONSTRAINT IF EXISTS credit_notes_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.credit_note_items DROP CONSTRAINT IF EXISTS credit_note_items_credit_note_id_fkey;
ALTER TABLE IF EXISTS ONLY public.credit_limits DROP CONSTRAINT IF EXISTS credit_limits_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.coupon_usage DROP CONSTRAINT IF EXISTS coupon_usage_invoice_id_fkey;
ALTER TABLE IF EXISTS ONLY public.coupon_usage DROP CONSTRAINT IF EXISTS coupon_usage_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.coupon_usage DROP CONSTRAINT IF EXISTS coupon_usage_coupon_id_fkey;
ALTER TABLE IF EXISTS ONLY public.contracts DROP CONSTRAINT IF EXISTS contracts_device_id_fkey;
ALTER TABLE IF EXISTS ONLY public.contracts DROP CONSTRAINT IF EXISTS contracts_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.contract_services DROP CONSTRAINT IF EXISTS contract_services_service_id_fkey;
ALTER TABLE IF EXISTS ONLY public.contract_services DROP CONSTRAINT IF EXISTS contract_services_contract_id_fkey;
ALTER TABLE IF EXISTS ONLY public.complaints DROP CONSTRAINT IF EXISTS complaints_service_id_fkey;
ALTER TABLE IF EXISTS ONLY public.complaints DROP CONSTRAINT IF EXISTS complaints_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.complaints DROP CONSTRAINT IF EXISTS complaints_assigned_to_fkey;
ALTER TABLE IF EXISTS ONLY public.communication_logs DROP CONSTRAINT IF EXISTS communication_logs_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.communication_logs DROP CONSTRAINT IF EXISTS communication_logs_contacted_by_fkey;
ALTER TABLE IF EXISTS ONLY public.commissions DROP CONSTRAINT IF EXISTS commissions_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.commissions DROP CONSTRAINT IF EXISTS commissions_employee_id_fkey;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_parent_comment_id_fkey;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.checks DROP CONSTRAINT IF EXISTS checks_supplier_id_fkey;
ALTER TABLE IF EXISTS ONLY public.checks DROP CONSTRAINT IF EXISTS checks_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.certifications DROP CONSTRAINT IF EXISTS certifications_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.calls DROP CONSTRAINT IF EXISTS calls_handled_by_fkey;
ALTER TABLE IF EXISTS ONLY public.calls DROP CONSTRAINT IF EXISTS calls_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.call_recordings DROP CONSTRAINT IF EXISTS call_recordings_call_id_fkey;
ALTER TABLE IF EXISTS ONLY public.budgets DROP CONSTRAINT IF EXISTS budgets_category_id_fkey;
ALTER TABLE IF EXISTS ONLY public.bookmarks DROP CONSTRAINT IF EXISTS bookmarks_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.bank_reconciliation DROP CONSTRAINT IF EXISTS bank_reconciliation_reconciled_by_fkey;
ALTER TABLE IF EXISTS ONLY public.bank_reconciliation_items DROP CONSTRAINT IF EXISTS bank_reconciliation_items_transaction_id_fkey;
ALTER TABLE IF EXISTS ONLY public.bank_reconciliation_items DROP CONSTRAINT IF EXISTS bank_reconciliation_items_reconciliation_id_fkey;
ALTER TABLE IF EXISTS ONLY public.bank_reconciliation DROP CONSTRAINT IF EXISTS bank_reconciliation_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.audit_trail DROP CONSTRAINT IF EXISTS audit_trail_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.attendance DROP CONSTRAINT IF EXISTS attendance_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.attendance DROP CONSTRAINT IF EXISTS attendance_employee_id_fkey;
ALTER TABLE IF EXISTS ONLY public.attachments DROP CONSTRAINT IF EXISTS attachments_uploaded_by_fkey;
ALTER TABLE IF EXISTS ONLY public.attachments DROP CONSTRAINT IF EXISTS attachments_file_id_fkey;
ALTER TABLE IF EXISTS ONLY public.assets DROP CONSTRAINT IF EXISTS assets_assigned_to_fkey;
ALTER TABLE IF EXISTS ONLY public.approvals DROP CONSTRAINT IF EXISTS approvals_requested_by_fkey;
ALTER TABLE IF EXISTS ONLY public.approvals DROP CONSTRAINT IF EXISTS approvals_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY public.appointments DROP CONSTRAINT IF EXISTS appointments_device_id_fkey;
ALTER TABLE IF EXISTS ONLY public.appointments DROP CONSTRAINT IF EXISTS appointments_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.appointments DROP CONSTRAINT IF EXISTS appointments_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.appointments DROP CONSTRAINT IF EXISTS appointments_assigned_technician_id_fkey;
ALTER TABLE IF EXISTS ONLY public.api_rate_limits DROP CONSTRAINT IF EXISTS api_rate_limits_api_key_id_fkey;
ALTER TABLE IF EXISTS ONLY public.advance_payments DROP CONSTRAINT IF EXISTS advance_payments_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.advance_payments DROP CONSTRAINT IF EXISTS advance_payments_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.activity_logs DROP CONSTRAINT IF EXISTS activity_logs_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.account_transactions DROP CONSTRAINT IF EXISTS account_transactions_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.account_transactions DROP CONSTRAINT IF EXISTS account_transactions_account_id_fkey;
DROP INDEX IF EXISTS public.idx_webhook_logs_webhook;
DROP INDEX IF EXISTS public.idx_warranties_entity;
DROP INDEX IF EXISTS public.idx_warranties_dates;
DROP INDEX IF EXISTS public.idx_versions_entity;
DROP INDEX IF EXISTS public.idx_users_status;
DROP INDEX IF EXISTS public.idx_users_email;
DROP INDEX IF EXISTS public.idx_user_sessions_user;
DROP INDEX IF EXISTS public.idx_user_sessions_token;
DROP INDEX IF EXISTS public.idx_technicians_status;
DROP INDEX IF EXISTS public.idx_technicians_employee_number;
DROP INDEX IF EXISTS public.idx_technician_reviews_technician;
DROP INDEX IF EXISTS public.idx_technician_locations_tech_time;
DROP INDEX IF EXISTS public.idx_tasks_status;
DROP INDEX IF EXISTS public.idx_tasks_assigned;
DROP INDEX IF EXISTS public.idx_stock_movements_warehouse;
DROP INDEX IF EXISTS public.idx_stock_movements_part;
DROP INDEX IF EXISTS public.idx_services_technician;
DROP INDEX IF EXISTS public.idx_services_status;
DROP INDEX IF EXISTS public.idx_services_device_date;
DROP INDEX IF EXISTS public.idx_services_date;
DROP INDEX IF EXISTS public.idx_services_customer_date;
DROP INDEX IF EXISTS public.idx_service_zones_active;
DROP INDEX IF EXISTS public.idx_service_ratings_service;
DROP INDEX IF EXISTS public.idx_service_photos_type;
DROP INDEX IF EXISTS public.idx_service_photos_service;
DROP INDEX IF EXISTS public.idx_routes_technician_date;
DROP INDEX IF EXISTS public.idx_return_requests_customer;
DROP INDEX IF EXISTS public.idx_quotations_status;
DROP INDEX IF EXISTS public.idx_quotations_customer;
DROP INDEX IF EXISTS public.idx_queue_jobs_status;
DROP INDEX IF EXISTS public.idx_payments_date;
DROP INDEX IF EXISTS public.idx_payments_customer;
DROP INDEX IF EXISTS public.idx_payment_plans_service;
DROP INDEX IF EXISTS public.idx_payment_plans_customer;
DROP INDEX IF EXISTS public.idx_parts_supplier;
DROP INDEX IF EXISTS public.idx_parts_status;
DROP INDEX IF EXISTS public.idx_parts_sku;
DROP INDEX IF EXISTS public.idx_parts_code;
DROP INDEX IF EXISTS public.idx_parts_barcode;
DROP INDEX IF EXISTS public.idx_part_suppliers_supplier;
DROP INDEX IF EXISTS public.idx_part_suppliers_part;
DROP INDEX IF EXISTS public.idx_part_returns_service_part;
DROP INDEX IF EXISTS public.idx_part_photos_part;
DROP INDEX IF EXISTS public.idx_overtime_employee;
DROP INDEX IF EXISTS public.idx_notifications_user;
DROP INDEX IF EXISTS public.idx_maintenance_schedules_device;
DROP INDEX IF EXISTS public.idx_login_attempts_time;
DROP INDEX IF EXISTS public.idx_login_attempts_ip;
DROP INDEX IF EXISTS public.idx_licenses_expiry;
DROP INDEX IF EXISTS public.idx_leaves_technician;
DROP INDEX IF EXISTS public.idx_leaves_employee;
DROP INDEX IF EXISTS public.idx_invoices_status;
DROP INDEX IF EXISTS public.idx_invoices_date;
DROP INDEX IF EXISTS public.idx_invoices_customer_status;
DROP INDEX IF EXISTS public.idx_invoices_customer;
DROP INDEX IF EXISTS public.idx_insurance_expiry;
DROP INDEX IF EXISTS public.idx_files_entity;
DROP INDEX IF EXISTS public.idx_files_created;
DROP INDEX IF EXISTS public.idx_fault_codes_code;
DROP INDEX IF EXISTS public.idx_expenses_status;
DROP INDEX IF EXISTS public.idx_expenses_date_category;
DROP INDEX IF EXISTS public.idx_expenses_date;
DROP INDEX IF EXISTS public.idx_expenses_category;
DROP INDEX IF EXISTS public.idx_entity_tags_entity;
DROP INDEX IF EXISTS public.idx_employee_documents_employee;
DROP INDEX IF EXISTS public.idx_document_photos_entity;
DROP INDEX IF EXISTS public.idx_devices_serial;
DROP INDEX IF EXISTS public.idx_devices_customer;
DROP INDEX IF EXISTS public.idx_device_parts_part;
DROP INDEX IF EXISTS public.idx_device_parts_device;
DROP INDEX IF EXISTS public.idx_customers_status;
DROP INDEX IF EXISTS public.idx_customers_phone;
DROP INDEX IF EXISTS public.idx_customers_email;
DROP INDEX IF EXISTS public.idx_customer_notes_customer;
DROP INDEX IF EXISTS public.idx_customer_addresses_customer;
DROP INDEX IF EXISTS public.idx_current_accounts_type_entity;
DROP INDEX IF EXISTS public.idx_credit_notes_invoice;
DROP INDEX IF EXISTS public.idx_credit_notes_customer;
DROP INDEX IF EXISTS public.idx_contracts_status;
DROP INDEX IF EXISTS public.idx_contracts_customer;
DROP INDEX IF EXISTS public.idx_complaints_status;
DROP INDEX IF EXISTS public.idx_complaints_customer;
DROP INDEX IF EXISTS public.idx_communication_logs_customer;
DROP INDEX IF EXISTS public.idx_commissions_technician;
DROP INDEX IF EXISTS public.idx_commissions_employee;
DROP INDEX IF EXISTS public.idx_comments_entity;
DROP INDEX IF EXISTS public.idx_checks_status;
DROP INDEX IF EXISTS public.idx_checks_due_date;
DROP INDEX IF EXISTS public.idx_campaigns_dates;
DROP INDEX IF EXISTS public.idx_calls_date;
DROP INDEX IF EXISTS public.idx_calls_customer;
DROP INDEX IF EXISTS public.idx_audit_trail_user;
DROP INDEX IF EXISTS public.idx_audit_trail_entity;
DROP INDEX IF EXISTS public.idx_audit_trail_created;
DROP INDEX IF EXISTS public.idx_attendance_technician_date;
DROP INDEX IF EXISTS public.idx_attendance_employee_date;
DROP INDEX IF EXISTS public.idx_attachments_entity;
DROP INDEX IF EXISTS public.idx_assets_status;
DROP INDEX IF EXISTS public.idx_approvals_entity;
DROP INDEX IF EXISTS public.idx_appointments_technician;
DROP INDEX IF EXISTS public.idx_appointments_status;
DROP INDEX IF EXISTS public.idx_appointments_date_status;
DROP INDEX IF EXISTS public.idx_appointments_date;
DROP INDEX IF EXISTS public.idx_advance_payments_entity;
DROP INDEX IF EXISTS public.idx_activity_logs_user;
DROP INDEX IF EXISTS public.idx_activity_logs_entity;
DROP INDEX IF EXISTS public.idx_activity_logs_created;
ALTER TABLE IF EXISTS ONLY public.working_hours DROP CONSTRAINT IF EXISTS working_hours_technician_id_day_of_week_key;
ALTER TABLE IF EXISTS ONLY public.working_hours DROP CONSTRAINT IF EXISTS working_hours_pkey;
ALTER TABLE IF EXISTS ONLY public.workflows DROP CONSTRAINT IF EXISTS workflows_workflow_name_key;
ALTER TABLE IF EXISTS ONLY public.workflows DROP CONSTRAINT IF EXISTS workflows_pkey;
ALTER TABLE IF EXISTS ONLY public.workflow_steps DROP CONSTRAINT IF EXISTS workflow_steps_pkey;
ALTER TABLE IF EXISTS ONLY public.work_orders DROP CONSTRAINT IF EXISTS work_orders_work_order_number_key;
ALTER TABLE IF EXISTS ONLY public.work_orders DROP CONSTRAINT IF EXISTS work_orders_pkey;
ALTER TABLE IF EXISTS ONLY public.webhooks DROP CONSTRAINT IF EXISTS webhooks_pkey;
ALTER TABLE IF EXISTS ONLY public.webhook_logs DROP CONSTRAINT IF EXISTS webhook_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.warranty_claims DROP CONSTRAINT IF EXISTS warranty_claims_pkey;
ALTER TABLE IF EXISTS ONLY public.warranties DROP CONSTRAINT IF EXISTS warranties_pkey;
ALTER TABLE IF EXISTS ONLY public.warehouses DROP CONSTRAINT IF EXISTS warehouses_pkey;
ALTER TABLE IF EXISTS ONLY public.versions DROP CONSTRAINT IF EXISTS versions_pkey;
ALTER TABLE IF EXISTS ONLY public.vehicles DROP CONSTRAINT IF EXISTS vehicles_plate_number_key;
ALTER TABLE IF EXISTS ONLY public.vehicles DROP CONSTRAINT IF EXISTS vehicles_pkey;
ALTER TABLE IF EXISTS ONLY public.vehicle_stock DROP CONSTRAINT IF EXISTS vehicle_stock_technician_id_part_id_key;
ALTER TABLE IF EXISTS ONLY public.vehicle_stock DROP CONSTRAINT IF EXISTS vehicle_stock_pkey;
ALTER TABLE IF EXISTS ONLY public.vehicle_expenses DROP CONSTRAINT IF EXISTS vehicle_expenses_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_username_key;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email_key;
ALTER TABLE IF EXISTS ONLY public.user_sessions DROP CONSTRAINT IF EXISTS user_sessions_session_token_key;
ALTER TABLE IF EXISTS ONLY public.user_sessions DROP CONSTRAINT IF EXISTS user_sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.user_preferences DROP CONSTRAINT IF EXISTS user_preferences_user_id_key;
ALTER TABLE IF EXISTS ONLY public.user_preferences DROP CONSTRAINT IF EXISTS user_preferences_pkey;
ALTER TABLE IF EXISTS ONLY public.user_dashboard_widgets DROP CONSTRAINT IF EXISTS user_dashboard_widgets_user_id_widget_id_key;
ALTER TABLE IF EXISTS ONLY public.user_dashboard_widgets DROP CONSTRAINT IF EXISTS user_dashboard_widgets_pkey;
ALTER TABLE IF EXISTS ONLY public.two_factor_auth DROP CONSTRAINT IF EXISTS two_factor_auth_user_id_key;
ALTER TABLE IF EXISTS ONLY public.two_factor_auth DROP CONSTRAINT IF EXISTS two_factor_auth_pkey;
ALTER TABLE IF EXISTS ONLY public.transfers DROP CONSTRAINT IF EXISTS transfers_pkey;
ALTER TABLE IF EXISTS ONLY public.training_programs DROP CONSTRAINT IF EXISTS training_programs_pkey;
ALTER TABLE IF EXISTS ONLY public.time_off_requests DROP CONSTRAINT IF EXISTS time_off_requests_pkey;
ALTER TABLE IF EXISTS ONLY public.territories DROP CONSTRAINT IF EXISTS territories_territory_name_key;
ALTER TABLE IF EXISTS ONLY public.territories DROP CONSTRAINT IF EXISTS territories_territory_code_key;
ALTER TABLE IF EXISTS ONLY public.territories DROP CONSTRAINT IF EXISTS territories_pkey;
ALTER TABLE IF EXISTS ONLY public.technicians DROP CONSTRAINT IF EXISTS technicians_pkey;
ALTER TABLE IF EXISTS ONLY public.technician_trainings DROP CONSTRAINT IF EXISTS technician_trainings_pkey;
ALTER TABLE IF EXISTS ONLY public.technician_skills DROP CONSTRAINT IF EXISTS technician_skills_skill_name_key;
ALTER TABLE IF EXISTS ONLY public.technician_skills DROP CONSTRAINT IF EXISTS technician_skills_pkey;
ALTER TABLE IF EXISTS ONLY public.technician_skill_assignments DROP CONSTRAINT IF EXISTS technician_skill_assignments_technician_id_skill_id_key;
ALTER TABLE IF EXISTS ONLY public.technician_skill_assignments DROP CONSTRAINT IF EXISTS technician_skill_assignments_pkey;
ALTER TABLE IF EXISTS ONLY public.technician_reviews DROP CONSTRAINT IF EXISTS technician_reviews_pkey;
ALTER TABLE IF EXISTS ONLY public.technician_performance DROP CONSTRAINT IF EXISTS technician_performance_technician_id_period_month_period_ye_key;
ALTER TABLE IF EXISTS ONLY public.technician_performance DROP CONSTRAINT IF EXISTS technician_performance_pkey;
ALTER TABLE IF EXISTS ONLY public.technician_locations DROP CONSTRAINT IF EXISTS technician_locations_pkey;
ALTER TABLE IF EXISTS ONLY public.tax_declarations DROP CONSTRAINT IF EXISTS tax_declarations_pkey;
ALTER TABLE IF EXISTS ONLY public.tasks DROP CONSTRAINT IF EXISTS tasks_pkey;
ALTER TABLE IF EXISTS ONLY public.tags DROP CONSTRAINT IF EXISTS tags_tag_name_key;
ALTER TABLE IF EXISTS ONLY public.tags DROP CONSTRAINT IF EXISTS tags_pkey;
ALTER TABLE IF EXISTS ONLY public.system_settings DROP CONSTRAINT IF EXISTS system_settings_setting_key_key;
ALTER TABLE IF EXISTS ONLY public.system_settings DROP CONSTRAINT IF EXISTS system_settings_pkey;
ALTER TABLE IF EXISTS ONLY public.surveys DROP CONSTRAINT IF EXISTS surveys_pkey;
ALTER TABLE IF EXISTS ONLY public.survey_responses DROP CONSTRAINT IF EXISTS survey_responses_pkey;
ALTER TABLE IF EXISTS ONLY public.survey_questions DROP CONSTRAINT IF EXISTS survey_questions_pkey;
ALTER TABLE IF EXISTS ONLY public.survey_answers DROP CONSTRAINT IF EXISTS survey_answers_pkey;
ALTER TABLE IF EXISTS ONLY public.suppliers DROP CONSTRAINT IF EXISTS suppliers_pkey;
ALTER TABLE IF EXISTS ONLY public.subscriptions DROP CONSTRAINT IF EXISTS subscriptions_pkey;
ALTER TABLE IF EXISTS ONLY public.stock_movements DROP CONSTRAINT IF EXISTS stock_movements_pkey;
ALTER TABLE IF EXISTS ONLY public.stock_counts DROP CONSTRAINT IF EXISTS stock_counts_pkey;
ALTER TABLE IF EXISTS ONLY public.stock_count_items DROP CONSTRAINT IF EXISTS stock_count_items_pkey;
ALTER TABLE IF EXISTS ONLY public.sms_templates DROP CONSTRAINT IF EXISTS sms_templates_template_name_key;
ALTER TABLE IF EXISTS ONLY public.sms_templates DROP CONSTRAINT IF EXISTS sms_templates_pkey;
ALTER TABLE IF EXISTS ONLY public.sms_logs DROP CONSTRAINT IF EXISTS sms_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.shipping_methods DROP CONSTRAINT IF EXISTS shipping_methods_pkey;
ALTER TABLE IF EXISTS ONLY public.shipping_methods DROP CONSTRAINT IF EXISTS shipping_methods_method_name_key;
ALTER TABLE IF EXISTS ONLY public.shift_schedules DROP CONSTRAINT IF EXISTS shift_schedules_pkey;
ALTER TABLE IF EXISTS ONLY public.sgk_declarations DROP CONSTRAINT IF EXISTS sgk_declarations_pkey;
ALTER TABLE IF EXISTS ONLY public.services DROP CONSTRAINT IF EXISTS services_pkey;
ALTER TABLE IF EXISTS ONLY public.service_zones DROP CONSTRAINT IF EXISTS service_zones_zone_name_key;
ALTER TABLE IF EXISTS ONLY public.service_zones DROP CONSTRAINT IF EXISTS service_zones_pkey;
ALTER TABLE IF EXISTS ONLY public.service_ratings DROP CONSTRAINT IF EXISTS service_ratings_service_id_key;
ALTER TABLE IF EXISTS ONLY public.service_ratings DROP CONSTRAINT IF EXISTS service_ratings_pkey;
ALTER TABLE IF EXISTS ONLY public.service_photos DROP CONSTRAINT IF EXISTS service_photos_pkey;
ALTER TABLE IF EXISTS ONLY public.service_parts DROP CONSTRAINT IF EXISTS service_parts_pkey;
ALTER TABLE IF EXISTS ONLY public.service_checklists DROP CONSTRAINT IF EXISTS service_checklists_pkey;
ALTER TABLE IF EXISTS ONLY public.service_checklist_templates DROP CONSTRAINT IF EXISTS service_checklist_templates_pkey;
ALTER TABLE IF EXISTS ONLY public.service_checklist_responses DROP CONSTRAINT IF EXISTS service_checklist_responses_pkey;
ALTER TABLE IF EXISTS ONLY public.service_checklist_items DROP CONSTRAINT IF EXISTS service_checklist_items_pkey;
ALTER TABLE IF EXISTS ONLY public.service_areas DROP CONSTRAINT IF EXISTS service_areas_pkey;
ALTER TABLE IF EXISTS ONLY public.service_area_pricing DROP CONSTRAINT IF EXISTS service_area_pricing_pkey;
ALTER TABLE IF EXISTS ONLY public.scheduled_maintenance_history DROP CONSTRAINT IF EXISTS scheduled_maintenance_history_pkey;
ALTER TABLE IF EXISTS ONLY public.scheduled_jobs DROP CONSTRAINT IF EXISTS scheduled_jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.scheduled_jobs DROP CONSTRAINT IF EXISTS scheduled_jobs_job_name_key;
ALTER TABLE IF EXISTS ONLY public.saved_filters DROP CONSTRAINT IF EXISTS saved_filters_pkey;
ALTER TABLE IF EXISTS ONLY public.salaries DROP CONSTRAINT IF EXISTS salaries_pkey;
ALTER TABLE IF EXISTS ONLY public.routes DROP CONSTRAINT IF EXISTS routes_pkey;
ALTER TABLE IF EXISTS ONLY public.route_stops DROP CONSTRAINT IF EXISTS route_stops_pkey;
ALTER TABLE IF EXISTS ONLY public.roles DROP CONSTRAINT IF EXISTS roles_role_name_key;
ALTER TABLE IF EXISTS ONLY public.roles DROP CONSTRAINT IF EXISTS roles_pkey;
ALTER TABLE IF EXISTS ONLY public.role_permissions DROP CONSTRAINT IF EXISTS role_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.return_requests DROP CONSTRAINT IF EXISTS return_requests_return_number_key;
ALTER TABLE IF EXISTS ONLY public.return_requests DROP CONSTRAINT IF EXISTS return_requests_pkey;
ALTER TABLE IF EXISTS ONLY public.return_request_items DROP CONSTRAINT IF EXISTS return_request_items_pkey;
ALTER TABLE IF EXISTS ONLY public.report_schedules DROP CONSTRAINT IF EXISTS report_schedules_pkey;
ALTER TABLE IF EXISTS ONLY public.reminders DROP CONSTRAINT IF EXISTS reminders_pkey;
ALTER TABLE IF EXISTS ONLY public.referrals DROP CONSTRAINT IF EXISTS referrals_pkey;
ALTER TABLE IF EXISTS ONLY public.recurring_invoices DROP CONSTRAINT IF EXISTS recurring_invoices_pkey;
ALTER TABLE IF EXISTS ONLY public.quotations DROP CONSTRAINT IF EXISTS quotations_quotation_number_key;
ALTER TABLE IF EXISTS ONLY public.quotations DROP CONSTRAINT IF EXISTS quotations_pkey;
ALTER TABLE IF EXISTS ONLY public.quotation_items DROP CONSTRAINT IF EXISTS quotation_items_pkey;
ALTER TABLE IF EXISTS ONLY public.queue_jobs DROP CONSTRAINT IF EXISTS queue_jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.purchase_orders DROP CONSTRAINT IF EXISTS purchase_orders_pkey;
ALTER TABLE IF EXISTS ONLY public.purchase_order_items DROP CONSTRAINT IF EXISTS purchase_order_items_pkey;
ALTER TABLE IF EXISTS ONLY public.promissory_notes DROP CONSTRAINT IF EXISTS promissory_notes_pkey;
ALTER TABLE IF EXISTS ONLY public.price_lists DROP CONSTRAINT IF EXISTS price_lists_pkey;
ALTER TABLE IF EXISTS ONLY public.price_list_items DROP CONSTRAINT IF EXISTS price_list_items_pkey;
ALTER TABLE IF EXISTS ONLY public.price_history DROP CONSTRAINT IF EXISTS price_history_pkey;
ALTER TABLE IF EXISTS ONLY public.petty_cash DROP CONSTRAINT IF EXISTS petty_cash_pkey;
ALTER TABLE IF EXISTS ONLY public.permissions DROP CONSTRAINT IF EXISTS permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.permissions DROP CONSTRAINT IF EXISTS permissions_permission_name_key;
ALTER TABLE IF EXISTS ONLY public.payments_received DROP CONSTRAINT IF EXISTS payments_received_pkey;
ALTER TABLE IF EXISTS ONLY public.payment_terms DROP CONSTRAINT IF EXISTS payment_terms_term_name_key;
ALTER TABLE IF EXISTS ONLY public.payment_terms DROP CONSTRAINT IF EXISTS payment_terms_pkey;
ALTER TABLE IF EXISTS ONLY public.payment_plans DROP CONSTRAINT IF EXISTS payment_plans_pkey;
ALTER TABLE IF EXISTS ONLY public.payment_plan_installments DROP CONSTRAINT IF EXISTS payment_plan_installments_pkey;
ALTER TABLE IF EXISTS ONLY public.password_resets DROP CONSTRAINT IF EXISTS password_resets_reset_token_key;
ALTER TABLE IF EXISTS ONLY public.password_resets DROP CONSTRAINT IF EXISTS password_resets_pkey;
ALTER TABLE IF EXISTS ONLY public.parts DROP CONSTRAINT IF EXISTS parts_pkey;
ALTER TABLE IF EXISTS ONLY public.parts DROP CONSTRAINT IF EXISTS parts_part_code_key;
ALTER TABLE IF EXISTS ONLY public.partners DROP CONSTRAINT IF EXISTS partners_pkey;
ALTER TABLE IF EXISTS ONLY public.partner_transactions DROP CONSTRAINT IF EXISTS partner_transactions_pkey;
ALTER TABLE IF EXISTS ONLY public.partner_current_accounts DROP CONSTRAINT IF EXISTS partner_current_accounts_pkey;
ALTER TABLE IF EXISTS ONLY public.partner_current_accounts DROP CONSTRAINT IF EXISTS partner_current_accounts_partner_id_key;
ALTER TABLE IF EXISTS ONLY public.part_suppliers DROP CONSTRAINT IF EXISTS part_suppliers_pkey;
ALTER TABLE IF EXISTS ONLY public.part_suppliers DROP CONSTRAINT IF EXISTS part_suppliers_part_id_supplier_id_key;
ALTER TABLE IF EXISTS ONLY public.part_returns DROP CONSTRAINT IF EXISTS part_returns_pkey;
ALTER TABLE IF EXISTS ONLY public.part_photos DROP CONSTRAINT IF EXISTS part_photos_pkey;
ALTER TABLE IF EXISTS ONLY public.overtime DROP CONSTRAINT IF EXISTS overtime_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_pkey;
ALTER TABLE IF EXISTS ONLY public.notification_templates DROP CONSTRAINT IF EXISTS notification_templates_template_name_key;
ALTER TABLE IF EXISTS ONLY public.notification_templates DROP CONSTRAINT IF EXISTS notification_templates_pkey;
ALTER TABLE IF EXISTS ONLY public.notification_preferences DROP CONSTRAINT IF EXISTS notification_preferences_user_id_key;
ALTER TABLE IF EXISTS ONLY public.notification_preferences DROP CONSTRAINT IF EXISTS notification_preferences_pkey;
ALTER TABLE IF EXISTS ONLY public.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.migrations DROP CONSTRAINT IF EXISTS migrations_migration_name_key;
ALTER TABLE IF EXISTS ONLY public.marketing_messages DROP CONSTRAINT IF EXISTS marketing_messages_pkey;
ALTER TABLE IF EXISTS ONLY public.maintenance_schedules DROP CONSTRAINT IF EXISTS maintenance_schedules_pkey;
ALTER TABLE IF EXISTS ONLY public.login_attempts DROP CONSTRAINT IF EXISTS login_attempts_pkey;
ALTER TABLE IF EXISTS ONLY public.licenses DROP CONSTRAINT IF EXISTS licenses_pkey;
ALTER TABLE IF EXISTS ONLY public.leaves DROP CONSTRAINT IF EXISTS leaves_pkey;
ALTER TABLE IF EXISTS ONLY public.kpi_metrics DROP CONSTRAINT IF EXISTS kpi_metrics_pkey;
ALTER TABLE IF EXISTS ONLY public.ip_whitelist DROP CONSTRAINT IF EXISTS ip_whitelist_pkey;
ALTER TABLE IF EXISTS ONLY public.ip_whitelist DROP CONSTRAINT IF EXISTS ip_whitelist_ip_address_key;
ALTER TABLE IF EXISTS ONLY public.invoices DROP CONSTRAINT IF EXISTS invoices_pkey;
ALTER TABLE IF EXISTS ONLY public.invoices DROP CONSTRAINT IF EXISTS invoices_invoice_number_key;
ALTER TABLE IF EXISTS ONLY public.invoice_items DROP CONSTRAINT IF EXISTS invoice_items_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_adjustments DROP CONSTRAINT IF EXISTS inventory_adjustments_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_adjustment_items DROP CONSTRAINT IF EXISTS inventory_adjustment_items_pkey;
ALTER TABLE IF EXISTS ONLY public.internal_messages DROP CONSTRAINT IF EXISTS internal_messages_pkey;
ALTER TABLE IF EXISTS ONLY public.integration_logs DROP CONSTRAINT IF EXISTS integration_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.insurance_policies DROP CONSTRAINT IF EXISTS insurance_policies_policy_number_key;
ALTER TABLE IF EXISTS ONLY public.insurance_policies DROP CONSTRAINT IF EXISTS insurance_policies_pkey;
ALTER TABLE IF EXISTS ONLY public.installments DROP CONSTRAINT IF EXISTS installments_pkey;
ALTER TABLE IF EXISTS ONLY public.installment_plans DROP CONSTRAINT IF EXISTS installment_plans_pkey;
ALTER TABLE IF EXISTS ONLY public.holidays DROP CONSTRAINT IF EXISTS holidays_pkey;
ALTER TABLE IF EXISTS ONLY public.holidays DROP CONSTRAINT IF EXISTS holidays_holiday_date_key;
ALTER TABLE IF EXISTS ONLY public.files DROP CONSTRAINT IF EXISTS files_pkey;
ALTER TABLE IF EXISTS ONLY public.fault_codes DROP CONSTRAINT IF EXISTS fault_codes_pkey;
ALTER TABLE IF EXISTS ONLY public.fault_codes DROP CONSTRAINT IF EXISTS fault_codes_code_key;
ALTER TABLE IF EXISTS ONLY public.failed_jobs DROP CONSTRAINT IF EXISTS failed_jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.expenses DROP CONSTRAINT IF EXISTS expenses_pkey;
ALTER TABLE IF EXISTS ONLY public.expense_categories DROP CONSTRAINT IF EXISTS expense_categories_pkey;
ALTER TABLE IF EXISTS ONLY public.exchange_rates DROP CONSTRAINT IF EXISTS exchange_rates_pkey;
ALTER TABLE IF EXISTS ONLY public.entity_tags DROP CONSTRAINT IF EXISTS entity_tags_pkey;
ALTER TABLE IF EXISTS ONLY public.entity_tags DROP CONSTRAINT IF EXISTS entity_tags_entity_type_entity_id_tag_id_key;
ALTER TABLE IF EXISTS ONLY public.employees DROP CONSTRAINT IF EXISTS employees_pkey;
ALTER TABLE IF EXISTS ONLY public.employee_shifts DROP CONSTRAINT IF EXISTS employee_shifts_pkey;
ALTER TABLE IF EXISTS ONLY public.employee_documents DROP CONSTRAINT IF EXISTS employee_documents_pkey;
ALTER TABLE IF EXISTS ONLY public.emergency_contacts DROP CONSTRAINT IF EXISTS emergency_contacts_pkey;
ALTER TABLE IF EXISTS ONLY public.email_templates DROP CONSTRAINT IF EXISTS email_templates_template_name_key;
ALTER TABLE IF EXISTS ONLY public.email_templates DROP CONSTRAINT IF EXISTS email_templates_pkey;
ALTER TABLE IF EXISTS ONLY public.email_logs DROP CONSTRAINT IF EXISTS email_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.documents DROP CONSTRAINT IF EXISTS documents_pkey;
ALTER TABLE IF EXISTS ONLY public.document_photos DROP CONSTRAINT IF EXISTS document_photos_pkey;
ALTER TABLE IF EXISTS ONLY public.discount_codes DROP CONSTRAINT IF EXISTS discount_codes_pkey;
ALTER TABLE IF EXISTS ONLY public.discount_codes DROP CONSTRAINT IF EXISTS discount_codes_code_key;
ALTER TABLE IF EXISTS ONLY public.devices DROP CONSTRAINT IF EXISTS devices_serial_number_key;
ALTER TABLE IF EXISTS ONLY public.devices DROP CONSTRAINT IF EXISTS devices_pkey;
ALTER TABLE IF EXISTS ONLY public.device_parts DROP CONSTRAINT IF EXISTS device_parts_pkey;
ALTER TABLE IF EXISTS ONLY public.device_history DROP CONSTRAINT IF EXISTS device_history_pkey;
ALTER TABLE IF EXISTS ONLY public.device_documents DROP CONSTRAINT IF EXISTS device_documents_pkey;
ALTER TABLE IF EXISTS ONLY public.depreciation DROP CONSTRAINT IF EXISTS depreciation_pkey;
ALTER TABLE IF EXISTS ONLY public.debit_notes DROP CONSTRAINT IF EXISTS debit_notes_pkey;
ALTER TABLE IF EXISTS ONLY public.debit_notes DROP CONSTRAINT IF EXISTS debit_notes_debit_note_number_key;
ALTER TABLE IF EXISTS ONLY public.data_exports DROP CONSTRAINT IF EXISTS data_exports_pkey;
ALTER TABLE IF EXISTS ONLY public.dashboard_widgets DROP CONSTRAINT IF EXISTS dashboard_widgets_pkey;
ALTER TABLE IF EXISTS ONLY public.customers DROP CONSTRAINT IF EXISTS customers_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_preferences DROP CONSTRAINT IF EXISTS customer_preferences_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_preferences DROP CONSTRAINT IF EXISTS customer_preferences_customer_id_key;
ALTER TABLE IF EXISTS ONLY public.customer_notes DROP CONSTRAINT IF EXISTS customer_notes_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_contacts DROP CONSTRAINT IF EXISTS customer_contacts_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_addresses DROP CONSTRAINT IF EXISTS customer_addresses_pkey;
ALTER TABLE IF EXISTS ONLY public.current_accounts DROP CONSTRAINT IF EXISTS current_accounts_pkey;
ALTER TABLE IF EXISTS ONLY public.current_accounts DROP CONSTRAINT IF EXISTS current_accounts_account_type_entity_id_key;
ALTER TABLE IF EXISTS ONLY public.current_account_transactions DROP CONSTRAINT IF EXISTS current_account_transactions_pkey;
ALTER TABLE IF EXISTS ONLY public.credit_notes DROP CONSTRAINT IF EXISTS credit_notes_pkey;
ALTER TABLE IF EXISTS ONLY public.credit_notes DROP CONSTRAINT IF EXISTS credit_notes_credit_note_number_key;
ALTER TABLE IF EXISTS ONLY public.credit_note_items DROP CONSTRAINT IF EXISTS credit_note_items_pkey;
ALTER TABLE IF EXISTS ONLY public.credit_limits DROP CONSTRAINT IF EXISTS credit_limits_pkey;
ALTER TABLE IF EXISTS ONLY public.credit_limits DROP CONSTRAINT IF EXISTS credit_limits_customer_id_key;
ALTER TABLE IF EXISTS ONLY public.coupons DROP CONSTRAINT IF EXISTS coupons_pkey;
ALTER TABLE IF EXISTS ONLY public.coupons DROP CONSTRAINT IF EXISTS coupons_coupon_code_key;
ALTER TABLE IF EXISTS ONLY public.coupon_usage DROP CONSTRAINT IF EXISTS coupon_usage_pkey;
ALTER TABLE IF EXISTS ONLY public.contracts DROP CONSTRAINT IF EXISTS contracts_pkey;
ALTER TABLE IF EXISTS ONLY public.contract_services DROP CONSTRAINT IF EXISTS contract_services_pkey;
ALTER TABLE IF EXISTS ONLY public.complaints DROP CONSTRAINT IF EXISTS complaints_pkey;
ALTER TABLE IF EXISTS ONLY public.communication_logs DROP CONSTRAINT IF EXISTS communication_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.commissions DROP CONSTRAINT IF EXISTS commissions_pkey;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_pkey;
ALTER TABLE IF EXISTS ONLY public.checks DROP CONSTRAINT IF EXISTS checks_pkey;
ALTER TABLE IF EXISTS ONLY public.certifications DROP CONSTRAINT IF EXISTS certifications_pkey;
ALTER TABLE IF EXISTS ONLY public.capacity_planning DROP CONSTRAINT IF EXISTS capacity_planning_pkey;
ALTER TABLE IF EXISTS ONLY public.campaigns DROP CONSTRAINT IF EXISTS campaigns_pkey;
ALTER TABLE IF EXISTS ONLY public.calls DROP CONSTRAINT IF EXISTS calls_pkey;
ALTER TABLE IF EXISTS ONLY public.call_recordings DROP CONSTRAINT IF EXISTS call_recordings_pkey;
ALTER TABLE IF EXISTS ONLY public.budgets DROP CONSTRAINT IF EXISTS budgets_pkey;
ALTER TABLE IF EXISTS ONLY public.bookmarks DROP CONSTRAINT IF EXISTS bookmarks_user_id_entity_type_entity_id_key;
ALTER TABLE IF EXISTS ONLY public.bookmarks DROP CONSTRAINT IF EXISTS bookmarks_pkey;
ALTER TABLE IF EXISTS ONLY public.bank_reconciliation DROP CONSTRAINT IF EXISTS bank_reconciliation_pkey;
ALTER TABLE IF EXISTS ONLY public.bank_reconciliation_items DROP CONSTRAINT IF EXISTS bank_reconciliation_items_pkey;
ALTER TABLE IF EXISTS ONLY public.backup_logs DROP CONSTRAINT IF EXISTS backup_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.automation_rules DROP CONSTRAINT IF EXISTS automation_rules_rule_name_key;
ALTER TABLE IF EXISTS ONLY public.automation_rules DROP CONSTRAINT IF EXISTS automation_rules_pkey;
ALTER TABLE IF EXISTS ONLY public.audit_trail DROP CONSTRAINT IF EXISTS audit_trail_pkey;
ALTER TABLE IF EXISTS ONLY public.attendance DROP CONSTRAINT IF EXISTS attendance_technician_id_attendance_date_key;
ALTER TABLE IF EXISTS ONLY public.attendance DROP CONSTRAINT IF EXISTS attendance_pkey;
ALTER TABLE IF EXISTS ONLY public.attendance DROP CONSTRAINT IF EXISTS attendance_employee_id_attendance_date_key;
ALTER TABLE IF EXISTS ONLY public.attachments DROP CONSTRAINT IF EXISTS attachments_pkey;
ALTER TABLE IF EXISTS ONLY public.assets DROP CONSTRAINT IF EXISTS assets_pkey;
ALTER TABLE IF EXISTS ONLY public.assets DROP CONSTRAINT IF EXISTS assets_asset_code_key;
ALTER TABLE IF EXISTS ONLY public.approvals DROP CONSTRAINT IF EXISTS approvals_pkey;
ALTER TABLE IF EXISTS ONLY public.appointments DROP CONSTRAINT IF EXISTS appointments_pkey;
ALTER TABLE IF EXISTS ONLY public.api_rate_limits DROP CONSTRAINT IF EXISTS api_rate_limits_pkey;
ALTER TABLE IF EXISTS ONLY public.api_keys DROP CONSTRAINT IF EXISTS api_keys_pkey;
ALTER TABLE IF EXISTS ONLY public.advance_payments DROP CONSTRAINT IF EXISTS advance_payments_pkey;
ALTER TABLE IF EXISTS ONLY public.activity_logs DROP CONSTRAINT IF EXISTS activity_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts DROP CONSTRAINT IF EXISTS accounts_pkey;
ALTER TABLE IF EXISTS ONLY public.account_transactions DROP CONSTRAINT IF EXISTS account_transactions_pkey;
ALTER TABLE IF EXISTS public.working_hours ALTER COLUMN schedule_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.workflows ALTER COLUMN workflow_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.workflow_steps ALTER COLUMN step_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.work_orders ALTER COLUMN work_order_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.webhooks ALTER COLUMN webhook_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.webhook_logs ALTER COLUMN log_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.warranty_claims ALTER COLUMN claim_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.warranties ALTER COLUMN warranty_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.warehouses ALTER COLUMN warehouse_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.versions ALTER COLUMN version_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.vehicles ALTER COLUMN vehicle_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.vehicle_stock ALTER COLUMN vehicle_stock_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.vehicle_expenses ALTER COLUMN expense_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.users ALTER COLUMN user_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.user_sessions ALTER COLUMN session_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.user_preferences ALTER COLUMN preference_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.user_dashboard_widgets ALTER COLUMN user_widget_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.two_factor_auth ALTER COLUMN tfa_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.transfers ALTER COLUMN transfer_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.training_programs ALTER COLUMN program_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.time_off_requests ALTER COLUMN request_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.territories ALTER COLUMN territory_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.technicians ALTER COLUMN technician_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.technician_trainings ALTER COLUMN training_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.technician_skills ALTER COLUMN skill_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.technician_skill_assignments ALTER COLUMN assignment_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.technician_reviews ALTER COLUMN review_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.technician_performance ALTER COLUMN performance_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.technician_locations ALTER COLUMN location_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tax_declarations ALTER COLUMN declaration_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tasks ALTER COLUMN task_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tags ALTER COLUMN tag_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.system_settings ALTER COLUMN setting_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.surveys ALTER COLUMN survey_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.survey_responses ALTER COLUMN response_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.survey_questions ALTER COLUMN question_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.survey_answers ALTER COLUMN answer_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.suppliers ALTER COLUMN supplier_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.subscriptions ALTER COLUMN subscription_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.stock_movements ALTER COLUMN movement_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.stock_counts ALTER COLUMN count_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.stock_count_items ALTER COLUMN item_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sms_templates ALTER COLUMN template_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sms_logs ALTER COLUMN sms_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.shipping_methods ALTER COLUMN method_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.shift_schedules ALTER COLUMN schedule_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sgk_declarations ALTER COLUMN declaration_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.services ALTER COLUMN service_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.service_zones ALTER COLUMN zone_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.service_ratings ALTER COLUMN rating_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.service_photos ALTER COLUMN photo_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.service_parts ALTER COLUMN service_part_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.service_checklists ALTER COLUMN checklist_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.service_checklist_templates ALTER COLUMN template_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.service_checklist_responses ALTER COLUMN response_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.service_checklist_items ALTER COLUMN item_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.service_areas ALTER COLUMN area_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.service_area_pricing ALTER COLUMN pricing_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.scheduled_maintenance_history ALTER COLUMN history_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.scheduled_jobs ALTER COLUMN job_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.saved_filters ALTER COLUMN filter_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.salaries ALTER COLUMN salary_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.routes ALTER COLUMN route_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.route_stops ALTER COLUMN stop_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.roles ALTER COLUMN role_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.return_requests ALTER COLUMN return_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.return_request_items ALTER COLUMN item_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.report_schedules ALTER COLUMN schedule_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.reminders ALTER COLUMN reminder_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.referrals ALTER COLUMN referral_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.recurring_invoices ALTER COLUMN recurring_invoice_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.quotations ALTER COLUMN quotation_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.quotation_items ALTER COLUMN item_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.queue_jobs ALTER COLUMN job_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.purchase_orders ALTER COLUMN order_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.purchase_order_items ALTER COLUMN item_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.promissory_notes ALTER COLUMN note_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.price_lists ALTER COLUMN price_list_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.price_list_items ALTER COLUMN item_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.price_history ALTER COLUMN history_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.petty_cash ALTER COLUMN transaction_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.permissions ALTER COLUMN permission_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.payments_received ALTER COLUMN payment_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.payment_terms ALTER COLUMN term_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.payment_plans ALTER COLUMN plan_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.payment_plan_installments ALTER COLUMN installment_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.password_resets ALTER COLUMN reset_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.parts ALTER COLUMN part_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.partners ALTER COLUMN partner_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.partner_transactions ALTER COLUMN transaction_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.partner_current_accounts ALTER COLUMN account_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.part_suppliers ALTER COLUMN part_supplier_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.part_returns ALTER COLUMN return_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.part_photos ALTER COLUMN photo_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.overtime ALTER COLUMN overtime_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notifications ALTER COLUMN notification_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notification_templates ALTER COLUMN template_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notification_preferences ALTER COLUMN preference_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.migrations ALTER COLUMN migration_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.marketing_messages ALTER COLUMN message_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.maintenance_schedules ALTER COLUMN schedule_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.login_attempts ALTER COLUMN attempt_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.licenses ALTER COLUMN license_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.leaves ALTER COLUMN leave_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.kpi_metrics ALTER COLUMN metric_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ip_whitelist ALTER COLUMN whitelist_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.invoices ALTER COLUMN invoice_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.invoice_items ALTER COLUMN item_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.inventory_adjustments ALTER COLUMN adjustment_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.inventory_adjustment_items ALTER COLUMN item_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.internal_messages ALTER COLUMN message_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.integration_logs ALTER COLUMN log_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.insurance_policies ALTER COLUMN policy_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.installments ALTER COLUMN installment_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.installment_plans ALTER COLUMN plan_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.holidays ALTER COLUMN holiday_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.files ALTER COLUMN file_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.fault_codes ALTER COLUMN code_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.failed_jobs ALTER COLUMN failed_job_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.expenses ALTER COLUMN expense_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.expense_categories ALTER COLUMN category_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.exchange_rates ALTER COLUMN rate_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.entity_tags ALTER COLUMN entity_tag_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.employees ALTER COLUMN employee_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.employee_shifts ALTER COLUMN assignment_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.employee_documents ALTER COLUMN document_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.emergency_contacts ALTER COLUMN contact_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.email_templates ALTER COLUMN template_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.email_logs ALTER COLUMN email_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.documents ALTER COLUMN document_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.document_photos ALTER COLUMN photo_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.discount_codes ALTER COLUMN code_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.devices ALTER COLUMN device_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.device_parts ALTER COLUMN device_part_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.device_history ALTER COLUMN history_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.device_documents ALTER COLUMN document_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.depreciation ALTER COLUMN depreciation_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.debit_notes ALTER COLUMN debit_note_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.data_exports ALTER COLUMN export_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.dashboard_widgets ALTER COLUMN widget_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.customers ALTER COLUMN customer_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.customer_preferences ALTER COLUMN preference_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.customer_notes ALTER COLUMN note_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.customer_contacts ALTER COLUMN contact_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.customer_addresses ALTER COLUMN address_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.current_accounts ALTER COLUMN account_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.current_account_transactions ALTER COLUMN transaction_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.credit_notes ALTER COLUMN credit_note_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.credit_note_items ALTER COLUMN item_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.credit_limits ALTER COLUMN limit_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.coupons ALTER COLUMN coupon_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.coupon_usage ALTER COLUMN usage_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.contracts ALTER COLUMN contract_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.contract_services ALTER COLUMN contract_service_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.complaints ALTER COLUMN complaint_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.communication_logs ALTER COLUMN log_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.commissions ALTER COLUMN commission_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.comments ALTER COLUMN comment_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.checks ALTER COLUMN check_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.certifications ALTER COLUMN certification_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.campaigns ALTER COLUMN campaign_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.calls ALTER COLUMN call_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.call_recordings ALTER COLUMN recording_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.budgets ALTER COLUMN budget_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.bookmarks ALTER COLUMN bookmark_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.bank_reconciliation_items ALTER COLUMN item_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.bank_reconciliation ALTER COLUMN reconciliation_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.backup_logs ALTER COLUMN backup_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.automation_rules ALTER COLUMN rule_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.audit_trail ALTER COLUMN audit_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.attendance ALTER COLUMN attendance_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.attachments ALTER COLUMN attachment_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.assets ALTER COLUMN asset_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.approvals ALTER COLUMN approval_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.appointments ALTER COLUMN appointment_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.api_rate_limits ALTER COLUMN limit_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.api_keys ALTER COLUMN key_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.advance_payments ALTER COLUMN advance_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.activity_logs ALTER COLUMN log_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.accounts ALTER COLUMN account_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.account_transactions ALTER COLUMN transaction_id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.working_hours_schedule_id_seq;
DROP TABLE IF EXISTS public.working_hours;
DROP SEQUENCE IF EXISTS public.workflows_workflow_id_seq;
DROP TABLE IF EXISTS public.workflows;
DROP SEQUENCE IF EXISTS public.workflow_steps_step_id_seq;
DROP TABLE IF EXISTS public.workflow_steps;
DROP SEQUENCE IF EXISTS public.work_orders_work_order_id_seq;
DROP TABLE IF EXISTS public.work_orders;
DROP SEQUENCE IF EXISTS public.webhooks_webhook_id_seq;
DROP TABLE IF EXISTS public.webhooks;
DROP SEQUENCE IF EXISTS public.webhook_logs_log_id_seq;
DROP TABLE IF EXISTS public.webhook_logs;
DROP SEQUENCE IF EXISTS public.warranty_claims_claim_id_seq;
DROP TABLE IF EXISTS public.warranty_claims;
DROP SEQUENCE IF EXISTS public.warranties_warranty_id_seq;
DROP TABLE IF EXISTS public.warranties;
DROP SEQUENCE IF EXISTS public.warehouses_warehouse_id_seq;
DROP TABLE IF EXISTS public.warehouses;
DROP SEQUENCE IF EXISTS public.versions_version_id_seq;
DROP TABLE IF EXISTS public.versions;
DROP SEQUENCE IF EXISTS public.vehicles_vehicle_id_seq;
DROP TABLE IF EXISTS public.vehicles;
DROP SEQUENCE IF EXISTS public.vehicle_stock_vehicle_stock_id_seq;
DROP TABLE IF EXISTS public.vehicle_stock;
DROP SEQUENCE IF EXISTS public.vehicle_expenses_expense_id_seq;
DROP TABLE IF EXISTS public.vehicle_expenses;
DROP SEQUENCE IF EXISTS public.users_user_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.user_sessions_session_id_seq;
DROP TABLE IF EXISTS public.user_sessions;
DROP SEQUENCE IF EXISTS public.user_preferences_preference_id_seq;
DROP TABLE IF EXISTS public.user_preferences;
DROP SEQUENCE IF EXISTS public.user_dashboard_widgets_user_widget_id_seq;
DROP TABLE IF EXISTS public.user_dashboard_widgets;
DROP SEQUENCE IF EXISTS public.two_factor_auth_tfa_id_seq;
DROP TABLE IF EXISTS public.two_factor_auth;
DROP SEQUENCE IF EXISTS public.transfers_transfer_id_seq;
DROP TABLE IF EXISTS public.transfers;
DROP SEQUENCE IF EXISTS public.training_programs_program_id_seq;
DROP TABLE IF EXISTS public.training_programs;
DROP SEQUENCE IF EXISTS public.time_off_requests_request_id_seq;
DROP TABLE IF EXISTS public.time_off_requests;
DROP SEQUENCE IF EXISTS public.territories_territory_id_seq;
DROP TABLE IF EXISTS public.territories;
DROP SEQUENCE IF EXISTS public.technicians_technician_id_seq;
DROP TABLE IF EXISTS public.technicians;
DROP SEQUENCE IF EXISTS public.technician_trainings_training_id_seq;
DROP TABLE IF EXISTS public.technician_trainings;
DROP SEQUENCE IF EXISTS public.technician_skills_skill_id_seq;
DROP TABLE IF EXISTS public.technician_skills;
DROP SEQUENCE IF EXISTS public.technician_skill_assignments_assignment_id_seq;
DROP TABLE IF EXISTS public.technician_skill_assignments;
DROP SEQUENCE IF EXISTS public.technician_reviews_review_id_seq;
DROP TABLE IF EXISTS public.technician_reviews;
DROP SEQUENCE IF EXISTS public.technician_performance_performance_id_seq;
DROP TABLE IF EXISTS public.technician_performance;
DROP SEQUENCE IF EXISTS public.technician_locations_location_id_seq;
DROP TABLE IF EXISTS public.technician_locations;
DROP SEQUENCE IF EXISTS public.tax_declarations_declaration_id_seq;
DROP TABLE IF EXISTS public.tax_declarations;
DROP SEQUENCE IF EXISTS public.tasks_task_id_seq;
DROP TABLE IF EXISTS public.tasks;
DROP SEQUENCE IF EXISTS public.tags_tag_id_seq;
DROP TABLE IF EXISTS public.tags;
DROP SEQUENCE IF EXISTS public.system_settings_setting_id_seq;
DROP TABLE IF EXISTS public.system_settings;
DROP SEQUENCE IF EXISTS public.surveys_survey_id_seq;
DROP TABLE IF EXISTS public.surveys;
DROP SEQUENCE IF EXISTS public.survey_responses_response_id_seq;
DROP TABLE IF EXISTS public.survey_responses;
DROP SEQUENCE IF EXISTS public.survey_questions_question_id_seq;
DROP TABLE IF EXISTS public.survey_questions;
DROP SEQUENCE IF EXISTS public.survey_answers_answer_id_seq;
DROP TABLE IF EXISTS public.survey_answers;
DROP SEQUENCE IF EXISTS public.suppliers_supplier_id_seq;
DROP TABLE IF EXISTS public.suppliers;
DROP SEQUENCE IF EXISTS public.subscriptions_subscription_id_seq;
DROP TABLE IF EXISTS public.subscriptions;
DROP SEQUENCE IF EXISTS public.stock_movements_movement_id_seq;
DROP TABLE IF EXISTS public.stock_movements;
DROP SEQUENCE IF EXISTS public.stock_counts_count_id_seq;
DROP TABLE IF EXISTS public.stock_counts;
DROP SEQUENCE IF EXISTS public.stock_count_items_item_id_seq;
DROP TABLE IF EXISTS public.stock_count_items;
DROP SEQUENCE IF EXISTS public.sms_templates_template_id_seq;
DROP TABLE IF EXISTS public.sms_templates;
DROP SEQUENCE IF EXISTS public.sms_logs_sms_id_seq;
DROP TABLE IF EXISTS public.sms_logs;
DROP SEQUENCE IF EXISTS public.shipping_methods_method_id_seq;
DROP TABLE IF EXISTS public.shipping_methods;
DROP SEQUENCE IF EXISTS public.shift_schedules_schedule_id_seq;
DROP TABLE IF EXISTS public.shift_schedules;
DROP SEQUENCE IF EXISTS public.sgk_declarations_declaration_id_seq;
DROP TABLE IF EXISTS public.sgk_declarations;
DROP SEQUENCE IF EXISTS public.services_service_id_seq;
DROP TABLE IF EXISTS public.services;
DROP SEQUENCE IF EXISTS public.service_zones_zone_id_seq;
DROP TABLE IF EXISTS public.service_zones;
DROP SEQUENCE IF EXISTS public.service_ratings_rating_id_seq;
DROP TABLE IF EXISTS public.service_ratings;
DROP SEQUENCE IF EXISTS public.service_photos_photo_id_seq;
DROP TABLE IF EXISTS public.service_photos;
DROP SEQUENCE IF EXISTS public.service_parts_service_part_id_seq;
DROP TABLE IF EXISTS public.service_parts;
DROP SEQUENCE IF EXISTS public.service_checklists_checklist_id_seq;
DROP TABLE IF EXISTS public.service_checklists;
DROP SEQUENCE IF EXISTS public.service_checklist_templates_template_id_seq;
DROP TABLE IF EXISTS public.service_checklist_templates;
DROP SEQUENCE IF EXISTS public.service_checklist_responses_response_id_seq;
DROP TABLE IF EXISTS public.service_checklist_responses;
DROP SEQUENCE IF EXISTS public.service_checklist_items_item_id_seq;
DROP TABLE IF EXISTS public.service_checklist_items;
DROP SEQUENCE IF EXISTS public.service_areas_area_id_seq;
DROP TABLE IF EXISTS public.service_areas;
DROP SEQUENCE IF EXISTS public.service_area_pricing_pricing_id_seq;
DROP TABLE IF EXISTS public.service_area_pricing;
DROP SEQUENCE IF EXISTS public.scheduled_maintenance_history_history_id_seq;
DROP TABLE IF EXISTS public.scheduled_maintenance_history;
DROP SEQUENCE IF EXISTS public.scheduled_jobs_job_id_seq;
DROP TABLE IF EXISTS public.scheduled_jobs;
DROP SEQUENCE IF EXISTS public.saved_filters_filter_id_seq;
DROP TABLE IF EXISTS public.saved_filters;
DROP SEQUENCE IF EXISTS public.salaries_salary_id_seq;
DROP TABLE IF EXISTS public.salaries;
DROP SEQUENCE IF EXISTS public.routes_route_id_seq;
DROP TABLE IF EXISTS public.routes;
DROP SEQUENCE IF EXISTS public.route_stops_stop_id_seq;
DROP TABLE IF EXISTS public.route_stops;
DROP SEQUENCE IF EXISTS public.roles_role_id_seq;
DROP TABLE IF EXISTS public.roles;
DROP TABLE IF EXISTS public.role_permissions;
DROP SEQUENCE IF EXISTS public.return_requests_return_id_seq;
DROP TABLE IF EXISTS public.return_requests;
DROP SEQUENCE IF EXISTS public.return_request_items_item_id_seq;
DROP TABLE IF EXISTS public.return_request_items;
DROP SEQUENCE IF EXISTS public.report_schedules_schedule_id_seq;
DROP TABLE IF EXISTS public.report_schedules;
DROP SEQUENCE IF EXISTS public.reminders_reminder_id_seq;
DROP TABLE IF EXISTS public.reminders;
DROP SEQUENCE IF EXISTS public.referrals_referral_id_seq;
DROP TABLE IF EXISTS public.referrals;
DROP SEQUENCE IF EXISTS public.recurring_invoices_recurring_invoice_id_seq;
DROP TABLE IF EXISTS public.recurring_invoices;
DROP SEQUENCE IF EXISTS public.quotations_quotation_id_seq;
DROP TABLE IF EXISTS public.quotations;
DROP SEQUENCE IF EXISTS public.quotation_items_item_id_seq;
DROP TABLE IF EXISTS public.quotation_items;
DROP SEQUENCE IF EXISTS public.queue_jobs_job_id_seq;
DROP TABLE IF EXISTS public.queue_jobs;
DROP SEQUENCE IF EXISTS public.purchase_orders_order_id_seq;
DROP TABLE IF EXISTS public.purchase_orders;
DROP SEQUENCE IF EXISTS public.purchase_order_items_item_id_seq;
DROP TABLE IF EXISTS public.purchase_order_items;
DROP SEQUENCE IF EXISTS public.promissory_notes_note_id_seq;
DROP TABLE IF EXISTS public.promissory_notes;
DROP SEQUENCE IF EXISTS public.price_lists_price_list_id_seq;
DROP TABLE IF EXISTS public.price_lists;
DROP SEQUENCE IF EXISTS public.price_list_items_item_id_seq;
DROP TABLE IF EXISTS public.price_list_items;
DROP SEQUENCE IF EXISTS public.price_history_history_id_seq;
DROP TABLE IF EXISTS public.price_history;
DROP SEQUENCE IF EXISTS public.petty_cash_transaction_id_seq;
DROP TABLE IF EXISTS public.petty_cash;
DROP SEQUENCE IF EXISTS public.permissions_permission_id_seq;
DROP TABLE IF EXISTS public.permissions;
DROP SEQUENCE IF EXISTS public.payments_received_payment_id_seq;
DROP TABLE IF EXISTS public.payments_received;
DROP SEQUENCE IF EXISTS public.payment_terms_term_id_seq;
DROP TABLE IF EXISTS public.payment_terms;
DROP SEQUENCE IF EXISTS public.payment_plans_plan_id_seq;
DROP TABLE IF EXISTS public.payment_plans;
DROP SEQUENCE IF EXISTS public.payment_plan_installments_installment_id_seq;
DROP TABLE IF EXISTS public.payment_plan_installments;
DROP SEQUENCE IF EXISTS public.password_resets_reset_id_seq;
DROP TABLE IF EXISTS public.password_resets;
DROP SEQUENCE IF EXISTS public.parts_part_id_seq;
DROP TABLE IF EXISTS public.parts;
DROP SEQUENCE IF EXISTS public.partners_partner_id_seq;
DROP TABLE IF EXISTS public.partners;
DROP SEQUENCE IF EXISTS public.partner_transactions_transaction_id_seq;
DROP TABLE IF EXISTS public.partner_transactions;
DROP SEQUENCE IF EXISTS public.partner_current_accounts_account_id_seq;
DROP TABLE IF EXISTS public.partner_current_accounts;
DROP SEQUENCE IF EXISTS public.part_suppliers_part_supplier_id_seq;
DROP TABLE IF EXISTS public.part_suppliers;
DROP SEQUENCE IF EXISTS public.part_returns_return_id_seq;
DROP TABLE IF EXISTS public.part_returns;
DROP SEQUENCE IF EXISTS public.part_photos_photo_id_seq;
DROP TABLE IF EXISTS public.part_photos;
DROP SEQUENCE IF EXISTS public.overtime_overtime_id_seq;
DROP TABLE IF EXISTS public.overtime;
DROP SEQUENCE IF EXISTS public.notifications_notification_id_seq;
DROP TABLE IF EXISTS public.notifications;
DROP SEQUENCE IF EXISTS public.notification_templates_template_id_seq;
DROP TABLE IF EXISTS public.notification_templates;
DROP SEQUENCE IF EXISTS public.notification_preferences_preference_id_seq;
DROP TABLE IF EXISTS public.notification_preferences;
DROP SEQUENCE IF EXISTS public.migrations_migration_id_seq;
DROP TABLE IF EXISTS public.migrations;
DROP SEQUENCE IF EXISTS public.marketing_messages_message_id_seq;
DROP TABLE IF EXISTS public.marketing_messages;
DROP SEQUENCE IF EXISTS public.maintenance_schedules_schedule_id_seq;
DROP TABLE IF EXISTS public.maintenance_schedules;
DROP SEQUENCE IF EXISTS public.login_attempts_attempt_id_seq;
DROP TABLE IF EXISTS public.login_attempts;
DROP SEQUENCE IF EXISTS public.licenses_license_id_seq;
DROP TABLE IF EXISTS public.licenses;
DROP SEQUENCE IF EXISTS public.leaves_leave_id_seq;
DROP TABLE IF EXISTS public.leaves;
DROP SEQUENCE IF EXISTS public.kpi_metrics_metric_id_seq;
DROP TABLE IF EXISTS public.kpi_metrics;
DROP SEQUENCE IF EXISTS public.ip_whitelist_whitelist_id_seq;
DROP TABLE IF EXISTS public.ip_whitelist;
DROP SEQUENCE IF EXISTS public.invoices_invoice_id_seq;
DROP TABLE IF EXISTS public.invoices;
DROP SEQUENCE IF EXISTS public.invoice_items_item_id_seq;
DROP TABLE IF EXISTS public.invoice_items;
DROP SEQUENCE IF EXISTS public.inventory_adjustments_adjustment_id_seq;
DROP TABLE IF EXISTS public.inventory_adjustments;
DROP SEQUENCE IF EXISTS public.inventory_adjustment_items_item_id_seq;
DROP TABLE IF EXISTS public.inventory_adjustment_items;
DROP SEQUENCE IF EXISTS public.internal_messages_message_id_seq;
DROP TABLE IF EXISTS public.internal_messages;
DROP SEQUENCE IF EXISTS public.integration_logs_log_id_seq;
DROP TABLE IF EXISTS public.integration_logs;
DROP SEQUENCE IF EXISTS public.insurance_policies_policy_id_seq;
DROP TABLE IF EXISTS public.insurance_policies;
DROP SEQUENCE IF EXISTS public.installments_installment_id_seq;
DROP TABLE IF EXISTS public.installments;
DROP SEQUENCE IF EXISTS public.installment_plans_plan_id_seq;
DROP TABLE IF EXISTS public.installment_plans;
DROP SEQUENCE IF EXISTS public.holidays_holiday_id_seq;
DROP TABLE IF EXISTS public.holidays;
DROP SEQUENCE IF EXISTS public.files_file_id_seq;
DROP TABLE IF EXISTS public.files;
DROP SEQUENCE IF EXISTS public.fault_codes_code_id_seq;
DROP TABLE IF EXISTS public.fault_codes;
DROP SEQUENCE IF EXISTS public.failed_jobs_failed_job_id_seq;
DROP TABLE IF EXISTS public.failed_jobs;
DROP SEQUENCE IF EXISTS public.expenses_expense_id_seq;
DROP TABLE IF EXISTS public.expenses;
DROP SEQUENCE IF EXISTS public.expense_categories_category_id_seq;
DROP TABLE IF EXISTS public.expense_categories;
DROP SEQUENCE IF EXISTS public.exchange_rates_rate_id_seq;
DROP TABLE IF EXISTS public.exchange_rates;
DROP SEQUENCE IF EXISTS public.entity_tags_entity_tag_id_seq;
DROP TABLE IF EXISTS public.entity_tags;
DROP SEQUENCE IF EXISTS public.employees_employee_id_seq;
DROP TABLE IF EXISTS public.employees;
DROP SEQUENCE IF EXISTS public.employee_shifts_assignment_id_seq;
DROP TABLE IF EXISTS public.employee_shifts;
DROP SEQUENCE IF EXISTS public.employee_documents_document_id_seq;
DROP TABLE IF EXISTS public.employee_documents;
DROP SEQUENCE IF EXISTS public.emergency_contacts_contact_id_seq;
DROP TABLE IF EXISTS public.emergency_contacts;
DROP SEQUENCE IF EXISTS public.email_templates_template_id_seq;
DROP TABLE IF EXISTS public.email_templates;
DROP SEQUENCE IF EXISTS public.email_logs_email_id_seq;
DROP TABLE IF EXISTS public.email_logs;
DROP SEQUENCE IF EXISTS public.documents_document_id_seq;
DROP TABLE IF EXISTS public.documents;
DROP SEQUENCE IF EXISTS public.document_photos_photo_id_seq;
DROP TABLE IF EXISTS public.document_photos;
DROP SEQUENCE IF EXISTS public.discount_codes_code_id_seq;
DROP TABLE IF EXISTS public.discount_codes;
DROP SEQUENCE IF EXISTS public.devices_device_id_seq;
DROP TABLE IF EXISTS public.devices;
DROP SEQUENCE IF EXISTS public.device_parts_device_part_id_seq;
DROP TABLE IF EXISTS public.device_parts;
DROP SEQUENCE IF EXISTS public.device_history_history_id_seq;
DROP TABLE IF EXISTS public.device_history;
DROP SEQUENCE IF EXISTS public.device_documents_document_id_seq;
DROP TABLE IF EXISTS public.device_documents;
DROP SEQUENCE IF EXISTS public.depreciation_depreciation_id_seq;
DROP TABLE IF EXISTS public.depreciation;
DROP SEQUENCE IF EXISTS public.debit_notes_debit_note_id_seq;
DROP TABLE IF EXISTS public.debit_notes;
DROP SEQUENCE IF EXISTS public.data_exports_export_id_seq;
DROP TABLE IF EXISTS public.data_exports;
DROP SEQUENCE IF EXISTS public.dashboard_widgets_widget_id_seq;
DROP TABLE IF EXISTS public.dashboard_widgets;
DROP SEQUENCE IF EXISTS public.customers_customer_id_seq;
DROP TABLE IF EXISTS public.customers;
DROP SEQUENCE IF EXISTS public.customer_preferences_preference_id_seq;
DROP TABLE IF EXISTS public.customer_preferences;
DROP SEQUENCE IF EXISTS public.customer_notes_note_id_seq;
DROP TABLE IF EXISTS public.customer_notes;
DROP SEQUENCE IF EXISTS public.customer_contacts_contact_id_seq;
DROP TABLE IF EXISTS public.customer_contacts;
DROP SEQUENCE IF EXISTS public.customer_addresses_address_id_seq;
DROP TABLE IF EXISTS public.customer_addresses;
DROP SEQUENCE IF EXISTS public.current_accounts_account_id_seq;
DROP TABLE IF EXISTS public.current_accounts;
DROP SEQUENCE IF EXISTS public.current_account_transactions_transaction_id_seq;
DROP TABLE IF EXISTS public.current_account_transactions;
DROP SEQUENCE IF EXISTS public.credit_notes_credit_note_id_seq;
DROP TABLE IF EXISTS public.credit_notes;
DROP SEQUENCE IF EXISTS public.credit_note_items_item_id_seq;
DROP TABLE IF EXISTS public.credit_note_items;
DROP SEQUENCE IF EXISTS public.credit_limits_limit_id_seq;
DROP TABLE IF EXISTS public.credit_limits;
DROP SEQUENCE IF EXISTS public.coupons_coupon_id_seq;
DROP TABLE IF EXISTS public.coupons;
DROP SEQUENCE IF EXISTS public.coupon_usage_usage_id_seq;
DROP TABLE IF EXISTS public.coupon_usage;
DROP SEQUENCE IF EXISTS public.contracts_contract_id_seq;
DROP TABLE IF EXISTS public.contracts;
DROP SEQUENCE IF EXISTS public.contract_services_contract_service_id_seq;
DROP TABLE IF EXISTS public.contract_services;
DROP SEQUENCE IF EXISTS public.complaints_complaint_id_seq;
DROP TABLE IF EXISTS public.complaints;
DROP SEQUENCE IF EXISTS public.communication_logs_log_id_seq;
DROP TABLE IF EXISTS public.communication_logs;
DROP SEQUENCE IF EXISTS public.commissions_commission_id_seq;
DROP TABLE IF EXISTS public.commissions;
DROP SEQUENCE IF EXISTS public.comments_comment_id_seq;
DROP TABLE IF EXISTS public.comments;
DROP SEQUENCE IF EXISTS public.checks_check_id_seq;
DROP TABLE IF EXISTS public.checks;
DROP SEQUENCE IF EXISTS public.certifications_certification_id_seq;
DROP TABLE IF EXISTS public.certifications;
DROP TABLE IF EXISTS public.capacity_planning;
DROP SEQUENCE IF EXISTS public.campaigns_campaign_id_seq;
DROP TABLE IF EXISTS public.campaigns;
DROP SEQUENCE IF EXISTS public.calls_call_id_seq;
DROP TABLE IF EXISTS public.calls;
DROP SEQUENCE IF EXISTS public.call_recordings_recording_id_seq;
DROP TABLE IF EXISTS public.call_recordings;
DROP SEQUENCE IF EXISTS public.budgets_budget_id_seq;
DROP TABLE IF EXISTS public.budgets;
DROP SEQUENCE IF EXISTS public.bookmarks_bookmark_id_seq;
DROP TABLE IF EXISTS public.bookmarks;
DROP SEQUENCE IF EXISTS public.bank_reconciliation_reconciliation_id_seq;
DROP SEQUENCE IF EXISTS public.bank_reconciliation_items_item_id_seq;
DROP TABLE IF EXISTS public.bank_reconciliation_items;
DROP TABLE IF EXISTS public.bank_reconciliation;
DROP SEQUENCE IF EXISTS public.backup_logs_backup_id_seq;
DROP TABLE IF EXISTS public.backup_logs;
DROP SEQUENCE IF EXISTS public.automation_rules_rule_id_seq;
DROP TABLE IF EXISTS public.automation_rules;
DROP SEQUENCE IF EXISTS public.audit_trail_audit_id_seq;
DROP TABLE IF EXISTS public.audit_trail;
DROP SEQUENCE IF EXISTS public.attendance_attendance_id_seq;
DROP TABLE IF EXISTS public.attendance;
DROP SEQUENCE IF EXISTS public.attachments_attachment_id_seq;
DROP TABLE IF EXISTS public.attachments;
DROP SEQUENCE IF EXISTS public.assets_asset_id_seq;
DROP TABLE IF EXISTS public.assets;
DROP SEQUENCE IF EXISTS public.approvals_approval_id_seq;
DROP TABLE IF EXISTS public.approvals;
DROP SEQUENCE IF EXISTS public.appointments_appointment_id_seq;
DROP TABLE IF EXISTS public.appointments;
DROP SEQUENCE IF EXISTS public.api_rate_limits_limit_id_seq;
DROP TABLE IF EXISTS public.api_rate_limits;
DROP SEQUENCE IF EXISTS public.api_keys_key_id_seq;
DROP TABLE IF EXISTS public.api_keys;
DROP SEQUENCE IF EXISTS public.advance_payments_advance_id_seq;
DROP TABLE IF EXISTS public.advance_payments;
DROP SEQUENCE IF EXISTS public.activity_logs_log_id_seq;
DROP TABLE IF EXISTS public.activity_logs;
DROP SEQUENCE IF EXISTS public.accounts_account_id_seq;
DROP TABLE IF EXISTS public.accounts;
DROP SEQUENCE IF EXISTS public.account_transactions_transaction_id_seq;
DROP TABLE IF EXISTS public.account_transactions;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_transactions; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.account_transactions (
    transaction_id integer NOT NULL,
    account_id integer,
    transaction_type character varying(20),
    transaction_date date NOT NULL,
    amount numeric(10,2) NOT NULL,
    balance_after numeric(15,2),
    reference_type character varying(50),
    reference_id integer,
    description text,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT account_transactions_transaction_type_check CHECK (((transaction_type)::text = ANY ((ARRAY['income'::character varying, 'expense'::character varying, 'transfer'::character varying])::text[])))
);


ALTER TABLE public.account_transactions OWNER TO akinadmin;

--
-- Name: account_transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.account_transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.account_transactions_transaction_id_seq OWNER TO akinadmin;

--
-- Name: account_transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.account_transactions_transaction_id_seq OWNED BY public.account_transactions.transaction_id;


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.accounts (
    account_id integer NOT NULL,
    account_type character varying(20),
    account_name character varying(100) NOT NULL,
    bank_name character varying(100),
    iban character varying(50),
    currency character varying(3) DEFAULT 'TRY'::character varying,
    current_balance numeric(15,2) DEFAULT 0,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT accounts_account_type_check CHECK (((account_type)::text = ANY ((ARRAY['cash'::character varying, 'bank'::character varying])::text[]))),
    CONSTRAINT accounts_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.accounts OWNER TO akinadmin;

--
-- Name: accounts_account_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.accounts_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.accounts_account_id_seq OWNER TO akinadmin;

--
-- Name: accounts_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.accounts_account_id_seq OWNED BY public.accounts.account_id;


--
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.activity_logs (
    log_id integer NOT NULL,
    user_id integer,
    action character varying(100) NOT NULL,
    entity_type character varying(50),
    entity_id integer,
    old_values jsonb,
    new_values jsonb,
    ip_address character varying(45),
    user_agent text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.activity_logs OWNER TO akinadmin;

--
-- Name: activity_logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.activity_logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activity_logs_log_id_seq OWNER TO akinadmin;

--
-- Name: activity_logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.activity_logs_log_id_seq OWNED BY public.activity_logs.log_id;


--
-- Name: advance_payments; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.advance_payments (
    advance_id integer NOT NULL,
    entity_type character varying(20),
    entity_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_date date NOT NULL,
    payment_method character varying(20),
    account_id integer,
    remaining_amount numeric(10,2),
    status character varying(20) DEFAULT 'active'::character varying,
    notes text,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT advance_payments_entity_type_check CHECK (((entity_type)::text = ANY ((ARRAY['customer'::character varying, 'supplier'::character varying, 'employee'::character varying])::text[]))),
    CONSTRAINT advance_payments_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'partially_used'::character varying, 'fully_used'::character varying, 'refunded'::character varying])::text[])))
);


ALTER TABLE public.advance_payments OWNER TO akinadmin;

--
-- Name: advance_payments_advance_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.advance_payments_advance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.advance_payments_advance_id_seq OWNER TO akinadmin;

--
-- Name: advance_payments_advance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.advance_payments_advance_id_seq OWNED BY public.advance_payments.advance_id;


--
-- Name: api_keys; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.api_keys (
    key_id integer NOT NULL,
    service_name character varying(100) NOT NULL,
    api_key character varying(255),
    api_secret character varying(255),
    endpoint_url character varying(500),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.api_keys OWNER TO akinadmin;

--
-- Name: api_keys_key_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.api_keys_key_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.api_keys_key_id_seq OWNER TO akinadmin;

--
-- Name: api_keys_key_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.api_keys_key_id_seq OWNED BY public.api_keys.key_id;


--
-- Name: api_rate_limits; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.api_rate_limits (
    limit_id integer NOT NULL,
    api_key_id integer,
    endpoint character varying(200),
    max_requests integer NOT NULL,
    time_window_seconds integer NOT NULL,
    current_count integer DEFAULT 0,
    window_start timestamp without time zone,
    is_active boolean DEFAULT true
);


ALTER TABLE public.api_rate_limits OWNER TO akinadmin;

--
-- Name: api_rate_limits_limit_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.api_rate_limits_limit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.api_rate_limits_limit_id_seq OWNER TO akinadmin;

--
-- Name: api_rate_limits_limit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.api_rate_limits_limit_id_seq OWNED BY public.api_rate_limits.limit_id;


--
-- Name: appointments; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.appointments (
    appointment_id integer NOT NULL,
    customer_id integer,
    device_id integer,
    appointment_date date NOT NULL,
    appointment_time time without time zone NOT NULL,
    appointment_type character varying(50),
    priority character varying(20) DEFAULT 'medium'::character varying,
    status character varying(20) DEFAULT 'pending'::character varying,
    assigned_technician_id integer,
    estimated_duration integer,
    notes text,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT appointments_appointment_type_check CHECK (((appointment_type)::text = ANY ((ARRAY['maintenance'::character varying, 'repair'::character varying, 'emergency'::character varying, 'installation'::character varying])::text[]))),
    CONSTRAINT appointments_priority_check CHECK (((priority)::text = ANY ((ARRAY['low'::character varying, 'medium'::character varying, 'high'::character varying, 'urgent'::character varying])::text[]))),
    CONSTRAINT appointments_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'confirmed'::character varying, 'in_progress'::character varying, 'completed'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.appointments OWNER TO akinadmin;

--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.appointments_appointment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointments_appointment_id_seq OWNER TO akinadmin;

--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.appointments_appointment_id_seq OWNED BY public.appointments.appointment_id;


--
-- Name: approvals; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.approvals (
    approval_id integer NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id integer NOT NULL,
    approval_type character varying(50),
    requested_by integer,
    requested_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    approved_by integer,
    approved_at timestamp without time zone,
    status character varying(20) DEFAULT 'pending'::character varying,
    comments text,
    CONSTRAINT approvals_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.approvals OWNER TO akinadmin;

--
-- Name: approvals_approval_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.approvals_approval_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.approvals_approval_id_seq OWNER TO akinadmin;

--
-- Name: approvals_approval_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.approvals_approval_id_seq OWNED BY public.approvals.approval_id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.assets (
    asset_id integer NOT NULL,
    asset_code character varying(50) NOT NULL,
    asset_name character varying(200) NOT NULL,
    asset_category character varying(100),
    purchase_date date,
    purchase_price numeric(15,2),
    current_value numeric(15,2),
    depreciation_method character varying(50),
    useful_life_years integer,
    salvage_value numeric(15,2),
    location character varying(200),
    assigned_to integer,
    status character varying(20) DEFAULT 'active'::character varying,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT assets_depreciation_method_check CHECK (((depreciation_method)::text = ANY ((ARRAY['straight_line'::character varying, 'declining_balance'::character varying, 'units_of_production'::character varying])::text[]))),
    CONSTRAINT assets_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'maintenance'::character varying, 'disposed'::character varying, 'sold'::character varying])::text[])))
);


ALTER TABLE public.assets OWNER TO akinadmin;

--
-- Name: assets_asset_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.assets_asset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assets_asset_id_seq OWNER TO akinadmin;

--
-- Name: assets_asset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.assets_asset_id_seq OWNED BY public.assets.asset_id;


--
-- Name: attachments; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.attachments (
    attachment_id integer NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id integer NOT NULL,
    file_id integer,
    attachment_type character varying(50),
    description text,
    uploaded_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.attachments OWNER TO akinadmin;

--
-- Name: attachments_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.attachments_attachment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attachments_attachment_id_seq OWNER TO akinadmin;

--
-- Name: attachments_attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.attachments_attachment_id_seq OWNED BY public.attachments.attachment_id;


--
-- Name: attendance; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.attendance (
    attendance_id integer NOT NULL,
    employee_id integer,
    technician_id integer,
    attendance_date date NOT NULL,
    check_in_time time without time zone,
    check_out_time time without time zone,
    total_hours numeric(5,2),
    status character varying(20),
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT attendance_status_check CHECK (((status)::text = ANY ((ARRAY['present'::character varying, 'absent'::character varying, 'late'::character varying, 'half_day'::character varying, 'leave'::character varying, 'holiday'::character varying])::text[])))
);


ALTER TABLE public.attendance OWNER TO akinadmin;

--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.attendance_attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendance_attendance_id_seq OWNER TO akinadmin;

--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.attendance_attendance_id_seq OWNED BY public.attendance.attendance_id;


--
-- Name: audit_trail; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.audit_trail (
    audit_id integer NOT NULL,
    user_id integer,
    action character varying(100) NOT NULL,
    entity_type character varying(50),
    entity_id integer,
    old_values jsonb,
    new_values jsonb,
    changes jsonb,
    ip_address character varying(45),
    user_agent text,
    session_id character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.audit_trail OWNER TO akinadmin;

--
-- Name: audit_trail_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.audit_trail_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_trail_audit_id_seq OWNER TO akinadmin;

--
-- Name: audit_trail_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.audit_trail_audit_id_seq OWNED BY public.audit_trail.audit_id;


--
-- Name: automation_rules; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.automation_rules (
    rule_id integer NOT NULL,
    rule_name character varying(100) NOT NULL,
    entity_type character varying(50),
    trigger_event character varying(100),
    conditions jsonb,
    actions jsonb,
    is_active boolean DEFAULT true,
    last_run_at timestamp without time zone,
    run_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.automation_rules OWNER TO akinadmin;

--
-- Name: automation_rules_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.automation_rules_rule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.automation_rules_rule_id_seq OWNER TO akinadmin;

--
-- Name: automation_rules_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.automation_rules_rule_id_seq OWNED BY public.automation_rules.rule_id;


--
-- Name: backup_logs; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.backup_logs (
    backup_id integer NOT NULL,
    backup_date timestamp without time zone NOT NULL,
    backup_type character varying(20),
    file_path character varying(500),
    file_size bigint,
    status character varying(20),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT backup_logs_backup_type_check CHECK (((backup_type)::text = ANY ((ARRAY['full'::character varying, 'incremental'::character varying])::text[]))),
    CONSTRAINT backup_logs_status_check CHECK (((status)::text = ANY ((ARRAY['success'::character varying, 'failed'::character varying])::text[])))
);


ALTER TABLE public.backup_logs OWNER TO akinadmin;

--
-- Name: backup_logs_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.backup_logs_backup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.backup_logs_backup_id_seq OWNER TO akinadmin;

--
-- Name: backup_logs_backup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.backup_logs_backup_id_seq OWNED BY public.backup_logs.backup_id;


--
-- Name: bank_reconciliation; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.bank_reconciliation (
    reconciliation_id integer NOT NULL,
    account_id integer,
    reconciliation_date date NOT NULL,
    statement_balance numeric(15,2),
    book_balance numeric(15,2),
    difference numeric(15,2),
    status character varying(20) DEFAULT 'pending'::character varying,
    reconciled_by integer,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT bank_reconciliation_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'in_progress'::character varying, 'completed'::character varying])::text[])))
);


ALTER TABLE public.bank_reconciliation OWNER TO akinadmin;

--
-- Name: bank_reconciliation_items; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.bank_reconciliation_items (
    item_id integer NOT NULL,
    reconciliation_id integer,
    transaction_id integer,
    is_matched boolean DEFAULT false,
    difference_amount numeric(10,2),
    notes text
);


ALTER TABLE public.bank_reconciliation_items OWNER TO akinadmin;

--
-- Name: bank_reconciliation_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.bank_reconciliation_items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bank_reconciliation_items_item_id_seq OWNER TO akinadmin;

--
-- Name: bank_reconciliation_items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.bank_reconciliation_items_item_id_seq OWNED BY public.bank_reconciliation_items.item_id;


--
-- Name: bank_reconciliation_reconciliation_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.bank_reconciliation_reconciliation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bank_reconciliation_reconciliation_id_seq OWNER TO akinadmin;

--
-- Name: bank_reconciliation_reconciliation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.bank_reconciliation_reconciliation_id_seq OWNED BY public.bank_reconciliation.reconciliation_id;


--
-- Name: bookmarks; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.bookmarks (
    bookmark_id integer NOT NULL,
    user_id integer,
    entity_type character varying(50) NOT NULL,
    entity_id integer NOT NULL,
    bookmark_name character varying(200),
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.bookmarks OWNER TO akinadmin;

--
-- Name: bookmarks_bookmark_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.bookmarks_bookmark_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookmarks_bookmark_id_seq OWNER TO akinadmin;

--
-- Name: bookmarks_bookmark_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.bookmarks_bookmark_id_seq OWNED BY public.bookmarks.bookmark_id;


--
-- Name: budgets; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.budgets (
    budget_id integer NOT NULL,
    budget_year integer NOT NULL,
    budget_month integer,
    category_id integer,
    planned_amount numeric(10,2),
    actual_amount numeric(10,2) DEFAULT 0,
    variance numeric(10,2),
    notes text,
    CONSTRAINT budgets_budget_month_check CHECK (((budget_month >= 1) AND (budget_month <= 12)))
);


ALTER TABLE public.budgets OWNER TO akinadmin;

--
-- Name: budgets_budget_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.budgets_budget_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.budgets_budget_id_seq OWNER TO akinadmin;

--
-- Name: budgets_budget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.budgets_budget_id_seq OWNED BY public.budgets.budget_id;


--
-- Name: call_recordings; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.call_recordings (
    recording_id integer NOT NULL,
    call_id integer,
    file_path character varying(255),
    duration integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.call_recordings OWNER TO akinadmin;

--
-- Name: call_recordings_recording_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.call_recordings_recording_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.call_recordings_recording_id_seq OWNER TO akinadmin;

--
-- Name: call_recordings_recording_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.call_recordings_recording_id_seq OWNED BY public.call_recordings.recording_id;


--
-- Name: calls; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.calls (
    call_id integer NOT NULL,
    customer_id integer,
    phone_number character varying(20),
    call_type character varying(20),
    call_date timestamp without time zone NOT NULL,
    call_duration integer,
    handled_by integer,
    call_result character varying(20),
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT calls_call_result_check CHECK (((call_result)::text = ANY ((ARRAY['answered'::character varying, 'missed'::character varying, 'busy'::character varying])::text[]))),
    CONSTRAINT calls_call_type_check CHECK (((call_type)::text = ANY ((ARRAY['incoming'::character varying, 'outgoing'::character varying])::text[])))
);


ALTER TABLE public.calls OWNER TO akinadmin;

--
-- Name: calls_call_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.calls_call_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.calls_call_id_seq OWNER TO akinadmin;

--
-- Name: calls_call_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.calls_call_id_seq OWNED BY public.calls.call_id;


--
-- Name: campaigns; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.campaigns (
    campaign_id integer NOT NULL,
    campaign_name character varying(200) NOT NULL,
    campaign_type character varying(50),
    start_date date NOT NULL,
    end_date date NOT NULL,
    discount_type character varying(20),
    discount_value numeric(10,2),
    target_segment character varying(100),
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT campaigns_campaign_type_check CHECK (((campaign_type)::text = ANY ((ARRAY['discount'::character varying, 'seasonal'::character varying, 'loyalty'::character varying])::text[]))),
    CONSTRAINT campaigns_discount_type_check CHECK (((discount_type)::text = ANY ((ARRAY['percentage'::character varying, 'fixed'::character varying])::text[]))),
    CONSTRAINT campaigns_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.campaigns OWNER TO akinadmin;

--
-- Name: campaigns_campaign_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.campaigns_campaign_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.campaigns_campaign_id_seq OWNER TO akinadmin;

--
-- Name: campaigns_campaign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.campaigns_campaign_id_seq OWNED BY public.campaigns.campaign_id;


--
-- Name: capacity_planning; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.capacity_planning (
    date date NOT NULL,
    available_technicians integer,
    total_appointments integer,
    capacity_percentage numeric(5,2)
);


ALTER TABLE public.capacity_planning OWNER TO akinadmin;

--
-- Name: certifications; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.certifications (
    certification_id integer NOT NULL,
    technician_id integer,
    certification_name character varying(200) NOT NULL,
    issuing_authority character varying(200),
    issue_date date,
    expiry_date date,
    certificate_number character varying(100),
    status character varying(20) DEFAULT 'active'::character varying,
    CONSTRAINT certifications_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'expired'::character varying, 'revoked'::character varying])::text[])))
);


ALTER TABLE public.certifications OWNER TO akinadmin;

--
-- Name: certifications_certification_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.certifications_certification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.certifications_certification_id_seq OWNER TO akinadmin;

--
-- Name: certifications_certification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.certifications_certification_id_seq OWNED BY public.certifications.certification_id;


--
-- Name: checks; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.checks (
    check_id integer NOT NULL,
    check_type character varying(20),
    check_number character varying(50) NOT NULL,
    bank_name character varying(100),
    branch character varying(100),
    account_number character varying(50),
    amount numeric(10,2) NOT NULL,
    issue_date date,
    due_date date NOT NULL,
    customer_id integer,
    supplier_id integer,
    status character varying(20) DEFAULT 'portfolio'::character varying,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT checks_check_type_check CHECK (((check_type)::text = ANY ((ARRAY['received'::character varying, 'issued'::character varying])::text[]))),
    CONSTRAINT checks_status_check CHECK (((status)::text = ANY ((ARRAY['portfolio'::character varying, 'bank'::character varying, 'collected'::character varying, 'bounced'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.checks OWNER TO akinadmin;

--
-- Name: checks_check_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.checks_check_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.checks_check_id_seq OWNER TO akinadmin;

--
-- Name: checks_check_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.checks_check_id_seq OWNED BY public.checks.check_id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.comments (
    comment_id integer NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id integer NOT NULL,
    comment_text text NOT NULL,
    parent_comment_id integer,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.comments OWNER TO akinadmin;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.comments_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_comment_id_seq OWNER TO akinadmin;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.comments_comment_id_seq OWNED BY public.comments.comment_id;


--
-- Name: commissions; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.commissions (
    commission_id integer NOT NULL,
    employee_id integer,
    technician_id integer,
    period_month integer,
    period_year integer,
    commission_type character varying(50),
    base_amount numeric(10,2),
    commission_rate numeric(5,2),
    commission_amount numeric(10,2),
    status character varying(20) DEFAULT 'pending'::character varying,
    paid_date date,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT commissions_commission_type_check CHECK (((commission_type)::text = ANY ((ARRAY['sales'::character varying, 'service'::character varying, 'performance'::character varying, 'bonus'::character varying])::text[]))),
    CONSTRAINT commissions_period_month_check CHECK (((period_month >= 1) AND (period_month <= 12))),
    CONSTRAINT commissions_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'paid'::character varying])::text[])))
);


ALTER TABLE public.commissions OWNER TO akinadmin;

--
-- Name: commissions_commission_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.commissions_commission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.commissions_commission_id_seq OWNER TO akinadmin;

--
-- Name: commissions_commission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.commissions_commission_id_seq OWNED BY public.commissions.commission_id;


--
-- Name: communication_logs; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.communication_logs (
    log_id integer NOT NULL,
    customer_id integer,
    communication_type character varying(20),
    direction character varying(20),
    subject character varying(200),
    content text,
    status character varying(20),
    contacted_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT communication_logs_communication_type_check CHECK (((communication_type)::text = ANY ((ARRAY['call'::character varying, 'sms'::character varying, 'email'::character varying, 'whatsapp'::character varying])::text[]))),
    CONSTRAINT communication_logs_direction_check CHECK (((direction)::text = ANY ((ARRAY['inbound'::character varying, 'outbound'::character varying])::text[]))),
    CONSTRAINT communication_logs_status_check CHECK (((status)::text = ANY ((ARRAY['sent'::character varying, 'delivered'::character varying, 'failed'::character varying, 'read'::character varying])::text[])))
);


ALTER TABLE public.communication_logs OWNER TO akinadmin;

--
-- Name: communication_logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.communication_logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.communication_logs_log_id_seq OWNER TO akinadmin;

--
-- Name: communication_logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.communication_logs_log_id_seq OWNED BY public.communication_logs.log_id;


--
-- Name: complaints; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.complaints (
    complaint_id integer NOT NULL,
    customer_id integer,
    service_id integer,
    complaint_date date NOT NULL,
    complaint_type character varying(100),
    description text,
    priority character varying(20) DEFAULT 'medium'::character varying,
    status character varying(20) DEFAULT 'open'::character varying,
    assigned_to integer,
    resolution text,
    resolved_date date,
    customer_satisfaction integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT complaints_customer_satisfaction_check CHECK (((customer_satisfaction >= 1) AND (customer_satisfaction <= 5))),
    CONSTRAINT complaints_priority_check CHECK (((priority)::text = ANY ((ARRAY['low'::character varying, 'medium'::character varying, 'high'::character varying])::text[]))),
    CONSTRAINT complaints_status_check CHECK (((status)::text = ANY ((ARRAY['open'::character varying, 'in_progress'::character varying, 'resolved'::character varying, 'closed'::character varying])::text[])))
);


ALTER TABLE public.complaints OWNER TO akinadmin;

--
-- Name: complaints_complaint_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.complaints_complaint_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.complaints_complaint_id_seq OWNER TO akinadmin;

--
-- Name: complaints_complaint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.complaints_complaint_id_seq OWNED BY public.complaints.complaint_id;


--
-- Name: contract_services; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.contract_services (
    contract_service_id integer NOT NULL,
    contract_id integer,
    service_id integer,
    scheduled_date date,
    completed_date date,
    status character varying(20) DEFAULT 'scheduled'::character varying,
    CONSTRAINT contract_services_status_check CHECK (((status)::text = ANY ((ARRAY['scheduled'::character varying, 'completed'::character varying, 'skipped'::character varying])::text[])))
);


ALTER TABLE public.contract_services OWNER TO akinadmin;

--
-- Name: contract_services_contract_service_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.contract_services_contract_service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contract_services_contract_service_id_seq OWNER TO akinadmin;

--
-- Name: contract_services_contract_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.contract_services_contract_service_id_seq OWNED BY public.contract_services.contract_service_id;


--
-- Name: contracts; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.contracts (
    contract_id integer NOT NULL,
    customer_id integer,
    device_id integer,
    contract_type character varying(20),
    start_date date NOT NULL,
    end_date date NOT NULL,
    renewal_date date,
    service_frequency character varying(20),
    contract_amount numeric(10,2),
    payment_frequency character varying(20),
    included_services text,
    status character varying(20) DEFAULT 'active'::character varying,
    auto_renewal boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT contracts_contract_type_check CHECK (((contract_type)::text = ANY ((ARRAY['monthly'::character varying, 'yearly'::character varying])::text[]))),
    CONSTRAINT contracts_payment_frequency_check CHECK (((payment_frequency)::text = ANY ((ARRAY['monthly'::character varying, 'yearly'::character varying])::text[]))),
    CONSTRAINT contracts_service_frequency_check CHECK (((service_frequency)::text = ANY ((ARRAY['monthly'::character varying, 'quarterly'::character varying, 'yearly'::character varying])::text[]))),
    CONSTRAINT contracts_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'expired'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.contracts OWNER TO akinadmin;

--
-- Name: contracts_contract_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.contracts_contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contracts_contract_id_seq OWNER TO akinadmin;

--
-- Name: contracts_contract_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.contracts_contract_id_seq OWNED BY public.contracts.contract_id;


--
-- Name: coupon_usage; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.coupon_usage (
    usage_id integer NOT NULL,
    coupon_id integer,
    customer_id integer,
    invoice_id integer,
    discount_amount numeric(10,2),
    used_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.coupon_usage OWNER TO akinadmin;

--
-- Name: coupon_usage_usage_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.coupon_usage_usage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coupon_usage_usage_id_seq OWNER TO akinadmin;

--
-- Name: coupon_usage_usage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.coupon_usage_usage_id_seq OWNED BY public.coupon_usage.usage_id;


--
-- Name: coupons; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.coupons (
    coupon_id integer NOT NULL,
    coupon_code character varying(50) NOT NULL,
    discount_type character varying(20),
    discount_value numeric(10,2),
    min_purchase_amount numeric(10,2),
    max_discount_amount numeric(10,2),
    usage_limit_per_customer integer,
    total_usage_limit integer,
    valid_from date,
    valid_until date,
    applicable_services text,
    status character varying(20) DEFAULT 'active'::character varying,
    CONSTRAINT coupons_discount_type_check CHECK (((discount_type)::text = ANY ((ARRAY['percentage'::character varying, 'fixed'::character varying])::text[]))),
    CONSTRAINT coupons_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.coupons OWNER TO akinadmin;

--
-- Name: coupons_coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.coupons_coupon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coupons_coupon_id_seq OWNER TO akinadmin;

--
-- Name: coupons_coupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.coupons_coupon_id_seq OWNED BY public.coupons.coupon_id;


--
-- Name: credit_limits; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.credit_limits (
    limit_id integer NOT NULL,
    customer_id integer,
    credit_limit numeric(15,2) NOT NULL,
    used_credit numeric(15,2) DEFAULT 0,
    available_credit numeric(15,2),
    payment_terms character varying(100),
    grace_period_days integer DEFAULT 0,
    interest_rate numeric(5,2),
    last_review_date date,
    next_review_date date,
    status character varying(20) DEFAULT 'active'::character varying,
    CONSTRAINT credit_limits_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'suspended'::character varying, 'revoked'::character varying])::text[])))
);


ALTER TABLE public.credit_limits OWNER TO akinadmin;

--
-- Name: credit_limits_limit_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.credit_limits_limit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.credit_limits_limit_id_seq OWNER TO akinadmin;

--
-- Name: credit_limits_limit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.credit_limits_limit_id_seq OWNED BY public.credit_limits.limit_id;


--
-- Name: credit_note_items; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.credit_note_items (
    item_id integer NOT NULL,
    credit_note_id integer,
    description text,
    quantity integer,
    unit_price numeric(10,2),
    tax_rate numeric(5,2),
    total_price numeric(10,2)
);


ALTER TABLE public.credit_note_items OWNER TO akinadmin;

--
-- Name: credit_note_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.credit_note_items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.credit_note_items_item_id_seq OWNER TO akinadmin;

--
-- Name: credit_note_items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.credit_note_items_item_id_seq OWNED BY public.credit_note_items.item_id;


--
-- Name: credit_notes; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.credit_notes (
    credit_note_id integer NOT NULL,
    credit_note_number character varying(50) NOT NULL,
    invoice_id integer,
    customer_id integer,
    credit_date date NOT NULL,
    reason text,
    subtotal numeric(10,2),
    tax_amount numeric(10,2),
    total_amount numeric(10,2),
    status character varying(20) DEFAULT 'draft'::character varying,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT credit_notes_status_check CHECK (((status)::text = ANY ((ARRAY['draft'::character varying, 'issued'::character varying, 'applied'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.credit_notes OWNER TO akinadmin;

--
-- Name: credit_notes_credit_note_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.credit_notes_credit_note_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.credit_notes_credit_note_id_seq OWNER TO akinadmin;

--
-- Name: credit_notes_credit_note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.credit_notes_credit_note_id_seq OWNED BY public.credit_notes.credit_note_id;


--
-- Name: current_account_transactions; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.current_account_transactions (
    transaction_id integer NOT NULL,
    account_id integer,
    transaction_type character varying(20),
    transaction_date date NOT NULL,
    amount numeric(15,2) NOT NULL,
    balance_after numeric(15,2),
    reference_type character varying(50),
    reference_id integer,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT current_account_transactions_transaction_type_check CHECK (((transaction_type)::text = ANY ((ARRAY['debit'::character varying, 'credit'::character varying])::text[])))
);


ALTER TABLE public.current_account_transactions OWNER TO akinadmin;

--
-- Name: current_account_transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.current_account_transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.current_account_transactions_transaction_id_seq OWNER TO akinadmin;

--
-- Name: current_account_transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.current_account_transactions_transaction_id_seq OWNED BY public.current_account_transactions.transaction_id;


--
-- Name: current_accounts; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.current_accounts (
    account_id integer NOT NULL,
    account_type character varying(20),
    entity_id integer NOT NULL,
    balance numeric(15,2) DEFAULT 0,
    credit_limit numeric(15,2),
    last_transaction_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT current_accounts_account_type_check CHECK (((account_type)::text = ANY ((ARRAY['customer'::character varying, 'supplier'::character varying, 'partner'::character varying, 'employee'::character varying])::text[])))
);


ALTER TABLE public.current_accounts OWNER TO akinadmin;

--
-- Name: current_accounts_account_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.current_accounts_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.current_accounts_account_id_seq OWNER TO akinadmin;

--
-- Name: current_accounts_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.current_accounts_account_id_seq OWNED BY public.current_accounts.account_id;


--
-- Name: customer_addresses; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.customer_addresses (
    address_id integer NOT NULL,
    customer_id integer,
    address_type character varying(20),
    address_line1 character varying(200),
    address_line2 character varying(200),
    city character varying(100),
    district character varying(100),
    postal_code character varying(10),
    country character varying(100) DEFAULT 'Turkey'::character varying,
    is_default boolean DEFAULT false,
    latitude numeric(10,8),
    longitude numeric(11,8),
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT customer_addresses_address_type_check CHECK (((address_type)::text = ANY ((ARRAY['billing'::character varying, 'service'::character varying, 'shipping'::character varying, 'other'::character varying])::text[])))
);


ALTER TABLE public.customer_addresses OWNER TO akinadmin;

--
-- Name: customer_addresses_address_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.customer_addresses_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_addresses_address_id_seq OWNER TO akinadmin;

--
-- Name: customer_addresses_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.customer_addresses_address_id_seq OWNED BY public.customer_addresses.address_id;


--
-- Name: customer_contacts; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.customer_contacts (
    contact_id integer NOT NULL,
    customer_id integer,
    name character varying(100),
    title character varying(100),
    phone character varying(20),
    email character varying(100),
    is_primary boolean DEFAULT false
);


ALTER TABLE public.customer_contacts OWNER TO akinadmin;

--
-- Name: customer_contacts_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.customer_contacts_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_contacts_contact_id_seq OWNER TO akinadmin;

--
-- Name: customer_contacts_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.customer_contacts_contact_id_seq OWNED BY public.customer_contacts.contact_id;


--
-- Name: customer_notes; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.customer_notes (
    note_id integer NOT NULL,
    customer_id integer,
    note_type character varying(50),
    note text NOT NULL,
    is_pinned boolean DEFAULT false,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT customer_notes_note_type_check CHECK (((note_type)::text = ANY ((ARRAY['general'::character varying, 'important'::character varying, 'warning'::character varying, 'preference'::character varying])::text[])))
);


ALTER TABLE public.customer_notes OWNER TO akinadmin;

--
-- Name: customer_notes_note_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.customer_notes_note_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_notes_note_id_seq OWNER TO akinadmin;

--
-- Name: customer_notes_note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.customer_notes_note_id_seq OWNED BY public.customer_notes.note_id;


--
-- Name: customer_preferences; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.customer_preferences (
    preference_id integer NOT NULL,
    customer_id integer,
    preferred_contact_method character varying(20),
    preferred_contact_time character varying(50),
    language_preference character varying(10) DEFAULT 'tr'::character varying,
    timezone character varying(50) DEFAULT 'Europe/Istanbul'::character varying,
    receive_marketing boolean DEFAULT true,
    receive_reminders boolean DEFAULT true,
    receive_surveys boolean DEFAULT true,
    CONSTRAINT customer_preferences_preferred_contact_method_check CHECK (((preferred_contact_method)::text = ANY ((ARRAY['phone'::character varying, 'email'::character varying, 'sms'::character varying, 'whatsapp'::character varying])::text[])))
);


ALTER TABLE public.customer_preferences OWNER TO akinadmin;

--
-- Name: customer_preferences_preference_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.customer_preferences_preference_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_preferences_preference_id_seq OWNER TO akinadmin;

--
-- Name: customer_preferences_preference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.customer_preferences_preference_id_seq OWNED BY public.customer_preferences.preference_id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    customer_type character varying(20),
    first_name character varying(100),
    last_name character varying(100),
    company_name character varying(200),
    tax_number character varying(50),
    tax_office character varying(100),
    phone character varying(20),
    email character varying(100),
    address text,
    city character varying(100),
    district character varying(100),
    postal_code character varying(10),
    loyalty_points integer DEFAULT 0,
    customer_segment character varying(50),
    notes text,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone,
    vat_number character varying(50),
    website character varying(200),
    industry character varying(100),
    company_size character varying(20),
    annual_revenue numeric(15,2),
    source character varying(50),
    assigned_sales_rep integer,
    preferred_contact_method character varying(20),
    language_preference character varying(10) DEFAULT 'tr'::character varying,
    timezone character varying(50) DEFAULT 'Europe/Istanbul'::character varying,
    customer_since date DEFAULT CURRENT_DATE,
    total_services_count integer DEFAULT 0,
    total_spent numeric(10,2) DEFAULT 0,
    CONSTRAINT customers_customer_type_check CHECK (((customer_type)::text = ANY ((ARRAY['individual'::character varying, 'corporate'::character varying])::text[]))),
    CONSTRAINT customers_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.customers OWNER TO akinadmin;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_customer_id_seq OWNER TO akinadmin;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.customers_customer_id_seq OWNED BY public.customers.customer_id;


--
-- Name: dashboard_widgets; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.dashboard_widgets (
    widget_id integer NOT NULL,
    widget_name character varying(100) NOT NULL,
    widget_type character varying(50),
    widget_config jsonb,
    position_x integer,
    position_y integer,
    width integer,
    height integer,
    is_active boolean DEFAULT true
);


ALTER TABLE public.dashboard_widgets OWNER TO akinadmin;

--
-- Name: dashboard_widgets_widget_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.dashboard_widgets_widget_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dashboard_widgets_widget_id_seq OWNER TO akinadmin;

--
-- Name: dashboard_widgets_widget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.dashboard_widgets_widget_id_seq OWNED BY public.dashboard_widgets.widget_id;


--
-- Name: data_exports; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.data_exports (
    export_id integer NOT NULL,
    export_name character varying(200),
    export_type character varying(50),
    entity_type character varying(50),
    filters jsonb,
    file_path character varying(500),
    file_size bigint,
    row_count integer,
    status character varying(20) DEFAULT 'pending'::character varying,
    requested_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    completed_at timestamp without time zone,
    CONSTRAINT data_exports_export_type_check CHECK (((export_type)::text = ANY ((ARRAY['csv'::character varying, 'excel'::character varying, 'pdf'::character varying, 'json'::character varying])::text[]))),
    CONSTRAINT data_exports_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'processing'::character varying, 'completed'::character varying, 'failed'::character varying])::text[])))
);


ALTER TABLE public.data_exports OWNER TO akinadmin;

--
-- Name: data_exports_export_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.data_exports_export_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.data_exports_export_id_seq OWNER TO akinadmin;

--
-- Name: data_exports_export_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.data_exports_export_id_seq OWNED BY public.data_exports.export_id;


--
-- Name: debit_notes; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.debit_notes (
    debit_note_id integer NOT NULL,
    debit_note_number character varying(50) NOT NULL,
    invoice_id integer,
    customer_id integer,
    debit_date date NOT NULL,
    reason text,
    amount numeric(10,2),
    status character varying(20) DEFAULT 'draft'::character varying,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT debit_notes_status_check CHECK (((status)::text = ANY ((ARRAY['draft'::character varying, 'issued'::character varying, 'applied'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.debit_notes OWNER TO akinadmin;

--
-- Name: debit_notes_debit_note_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.debit_notes_debit_note_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.debit_notes_debit_note_id_seq OWNER TO akinadmin;

--
-- Name: debit_notes_debit_note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.debit_notes_debit_note_id_seq OWNED BY public.debit_notes.debit_note_id;


--
-- Name: depreciation; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.depreciation (
    depreciation_id integer NOT NULL,
    asset_id integer,
    period_month integer,
    period_year integer,
    depreciation_amount numeric(10,2),
    accumulated_depreciation numeric(15,2),
    book_value numeric(15,2),
    calculated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT depreciation_period_month_check CHECK (((period_month >= 1) AND (period_month <= 12)))
);


ALTER TABLE public.depreciation OWNER TO akinadmin;

--
-- Name: depreciation_depreciation_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.depreciation_depreciation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.depreciation_depreciation_id_seq OWNER TO akinadmin;

--
-- Name: depreciation_depreciation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.depreciation_depreciation_id_seq OWNED BY public.depreciation.depreciation_id;


--
-- Name: device_documents; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.device_documents (
    document_id integer NOT NULL,
    device_id integer,
    document_type character varying(50),
    title character varying(200),
    file_id integer,
    issue_date date,
    expiry_date date,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT device_documents_document_type_check CHECK (((document_type)::text = ANY ((ARRAY['manual'::character varying, 'warranty'::character varying, 'certificate'::character varying, 'inspection'::character varying, 'other'::character varying])::text[])))
);


ALTER TABLE public.device_documents OWNER TO akinadmin;

--
-- Name: device_documents_document_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.device_documents_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.device_documents_document_id_seq OWNER TO akinadmin;

--
-- Name: device_documents_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.device_documents_document_id_seq OWNED BY public.device_documents.document_id;


--
-- Name: device_history; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.device_history (
    history_id integer NOT NULL,
    device_id integer,
    event_type character varying(50),
    event_date date,
    description text,
    technician_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT device_history_event_type_check CHECK (((event_type)::text = ANY ((ARRAY['installation'::character varying, 'maintenance'::character varying, 'repair'::character varying, 'replacement'::character varying])::text[])))
);


ALTER TABLE public.device_history OWNER TO akinadmin;

--
-- Name: device_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.device_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.device_history_history_id_seq OWNER TO akinadmin;

--
-- Name: device_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.device_history_history_id_seq OWNED BY public.device_history.history_id;


--
-- Name: device_parts; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.device_parts (
    device_part_id integer NOT NULL,
    device_id integer,
    part_id integer,
    installation_date date,
    installed_by integer,
    warranty_end_date date,
    status character varying(20) DEFAULT 'active'::character varying,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT device_parts_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'replaced'::character varying, 'removed'::character varying])::text[])))
);


ALTER TABLE public.device_parts OWNER TO akinadmin;

--
-- Name: device_parts_device_part_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.device_parts_device_part_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.device_parts_device_part_id_seq OWNER TO akinadmin;

--
-- Name: device_parts_device_part_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.device_parts_device_part_id_seq OWNED BY public.device_parts.device_part_id;


--
-- Name: devices; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.devices (
    device_id integer NOT NULL,
    customer_id integer,
    brand character varying(100),
    model character varying(100),
    serial_number character varying(100),
    installation_date date,
    warranty_start_date date,
    warranty_end_date date,
    last_maintenance_date date,
    next_maintenance_date date,
    device_status character varying(20) DEFAULT 'active'::character varying,
    location_notes text,
    qr_code character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    purchase_date date,
    purchase_price numeric(10,2),
    current_value numeric(10,2),
    condition character varying(20),
    power_consumption character varying(50),
    efficiency_rating character varying(20),
    last_inspection_date date,
    next_inspection_date date,
    manual_url character varying(500),
    parts_catalog_url character varying(500),
    last_service_date date,
    total_service_count integer DEFAULT 0,
    warranty_status character varying(50) DEFAULT 'unknown'::character varying,
    notes text,
    CONSTRAINT devices_device_status_check CHECK (((device_status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying, 'scrapped'::character varying])::text[])))
);


ALTER TABLE public.devices OWNER TO akinadmin;

--
-- Name: devices_device_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.devices_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.devices_device_id_seq OWNER TO akinadmin;

--
-- Name: devices_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.devices_device_id_seq OWNED BY public.devices.device_id;


--
-- Name: discount_codes; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.discount_codes (
    code_id integer NOT NULL,
    code character varying(50) NOT NULL,
    campaign_id integer,
    discount_type character varying(20),
    discount_value numeric(10,2),
    usage_limit integer,
    used_count integer DEFAULT 0,
    valid_from date,
    valid_until date,
    status character varying(20) DEFAULT 'active'::character varying,
    CONSTRAINT discount_codes_discount_type_check CHECK (((discount_type)::text = ANY ((ARRAY['percentage'::character varying, 'fixed'::character varying])::text[]))),
    CONSTRAINT discount_codes_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.discount_codes OWNER TO akinadmin;

--
-- Name: discount_codes_code_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.discount_codes_code_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.discount_codes_code_id_seq OWNER TO akinadmin;

--
-- Name: discount_codes_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.discount_codes_code_id_seq OWNED BY public.discount_codes.code_id;


--
-- Name: document_photos; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.document_photos (
    photo_id integer NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id integer NOT NULL,
    file_id integer,
    document_type character varying(50),
    description text,
    scan_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    scanned_by integer,
    CONSTRAINT document_photos_document_type_check CHECK (((document_type)::text = ANY ((ARRAY['invoice'::character varying, 'receipt'::character varying, 'contract'::character varying, 'warranty'::character varying, 'certificate'::character varying, 'id'::character varying, 'license'::character varying, 'other'::character varying])::text[])))
);


ALTER TABLE public.document_photos OWNER TO akinadmin;

--
-- Name: document_photos_photo_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.document_photos_photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.document_photos_photo_id_seq OWNER TO akinadmin;

--
-- Name: document_photos_photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.document_photos_photo_id_seq OWNED BY public.document_photos.photo_id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.documents (
    document_id integer NOT NULL,
    document_type character varying(50),
    title character varying(200) NOT NULL,
    description text,
    file_id integer,
    related_entity_type character varying(50),
    related_entity_id integer,
    version integer DEFAULT 1,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT documents_document_type_check CHECK (((document_type)::text = ANY ((ARRAY['manual'::character varying, 'warranty'::character varying, 'certificate'::character varying, 'contract'::character varying])::text[]))),
    CONSTRAINT documents_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'archived'::character varying])::text[])))
);


ALTER TABLE public.documents OWNER TO akinadmin;

--
-- Name: documents_document_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.documents_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.documents_document_id_seq OWNER TO akinadmin;

--
-- Name: documents_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.documents_document_id_seq OWNED BY public.documents.document_id;


--
-- Name: email_logs; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.email_logs (
    email_id integer NOT NULL,
    recipient_email character varying(100) NOT NULL,
    subject character varying(200),
    body text,
    status character varying(20),
    sent_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT email_logs_status_check CHECK (((status)::text = ANY ((ARRAY['sent'::character varying, 'failed'::character varying])::text[])))
);


ALTER TABLE public.email_logs OWNER TO akinadmin;

--
-- Name: email_logs_email_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.email_logs_email_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.email_logs_email_id_seq OWNER TO akinadmin;

--
-- Name: email_logs_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.email_logs_email_id_seq OWNED BY public.email_logs.email_id;


--
-- Name: email_templates; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.email_templates (
    template_id integer NOT NULL,
    template_name character varying(100) NOT NULL,
    subject character varying(200),
    body_html text,
    body_text text,
    variables jsonb,
    category character varying(50),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.email_templates OWNER TO akinadmin;

--
-- Name: email_templates_template_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.email_templates_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.email_templates_template_id_seq OWNER TO akinadmin;

--
-- Name: email_templates_template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.email_templates_template_id_seq OWNED BY public.email_templates.template_id;


--
-- Name: emergency_contacts; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.emergency_contacts (
    contact_id integer NOT NULL,
    employee_id integer,
    technician_id integer,
    contact_name character varying(100) NOT NULL,
    relationship character varying(50),
    phone character varying(20) NOT NULL,
    alternate_phone character varying(20),
    address text,
    is_primary boolean DEFAULT false
);


ALTER TABLE public.emergency_contacts OWNER TO akinadmin;

--
-- Name: emergency_contacts_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.emergency_contacts_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.emergency_contacts_contact_id_seq OWNER TO akinadmin;

--
-- Name: emergency_contacts_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.emergency_contacts_contact_id_seq OWNED BY public.emergency_contacts.contact_id;


--
-- Name: employee_documents; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.employee_documents (
    document_id integer NOT NULL,
    employee_id integer,
    document_type character varying(50),
    title character varying(200),
    file_id integer,
    issue_date date,
    expiry_date date,
    issuing_authority character varying(200),
    document_number character varying(100),
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT employee_documents_document_type_check CHECK (((document_type)::text = ANY ((ARRAY['id'::character varying, 'passport'::character varying, 'license'::character varying, 'certificate'::character varying, 'contract'::character varying, 'health'::character varying, 'other'::character varying])::text[])))
);


ALTER TABLE public.employee_documents OWNER TO akinadmin;

--
-- Name: employee_documents_document_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.employee_documents_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_documents_document_id_seq OWNER TO akinadmin;

--
-- Name: employee_documents_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.employee_documents_document_id_seq OWNED BY public.employee_documents.document_id;


--
-- Name: employee_shifts; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.employee_shifts (
    assignment_id integer NOT NULL,
    employee_id integer,
    technician_id integer,
    schedule_id integer,
    shift_date date NOT NULL,
    status character varying(20) DEFAULT 'scheduled'::character varying,
    CONSTRAINT employee_shifts_status_check CHECK (((status)::text = ANY ((ARRAY['scheduled'::character varying, 'completed'::character varying, 'absent'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.employee_shifts OWNER TO akinadmin;

--
-- Name: employee_shifts_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.employee_shifts_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_shifts_assignment_id_seq OWNER TO akinadmin;

--
-- Name: employee_shifts_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.employee_shifts_assignment_id_seq OWNED BY public.employee_shifts.assignment_id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    user_id integer,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    phone character varying(20),
    email character varying(100),
    "position" character varying(100),
    department character varying(100),
    hire_date date,
    salary numeric(10,2),
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT employees_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'on_leave'::character varying, 'terminated'::character varying])::text[])))
);


ALTER TABLE public.employees OWNER TO akinadmin;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_employee_id_seq OWNER TO akinadmin;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.employees_employee_id_seq OWNED BY public.employees.employee_id;


--
-- Name: entity_tags; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.entity_tags (
    entity_tag_id integer NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id integer NOT NULL,
    tag_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.entity_tags OWNER TO akinadmin;

--
-- Name: entity_tags_entity_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.entity_tags_entity_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.entity_tags_entity_tag_id_seq OWNER TO akinadmin;

--
-- Name: entity_tags_entity_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.entity_tags_entity_tag_id_seq OWNED BY public.entity_tags.entity_tag_id;


--
-- Name: exchange_rates; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.exchange_rates (
    rate_id integer NOT NULL,
    currency_code character varying(3) NOT NULL,
    rate numeric(10,4) NOT NULL,
    rate_date date NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.exchange_rates OWNER TO akinadmin;

--
-- Name: exchange_rates_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.exchange_rates_rate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exchange_rates_rate_id_seq OWNER TO akinadmin;

--
-- Name: exchange_rates_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.exchange_rates_rate_id_seq OWNED BY public.exchange_rates.rate_id;


--
-- Name: expense_categories; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.expense_categories (
    category_id integer NOT NULL,
    category_name character varying(100) NOT NULL,
    parent_category_id integer,
    budget_limit numeric(10,2),
    requires_approval boolean DEFAULT false
);


ALTER TABLE public.expense_categories OWNER TO akinadmin;

--
-- Name: expense_categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.expense_categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.expense_categories_category_id_seq OWNER TO akinadmin;

--
-- Name: expense_categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.expense_categories_category_id_seq OWNED BY public.expense_categories.category_id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.expenses (
    expense_id integer NOT NULL,
    expense_category_id integer,
    expense_date date NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_method character varying(20),
    account_id integer,
    supplier_id integer,
    description text,
    receipt_number character varying(100),
    tax_amount numeric(10,2),
    approval_status character varying(20) DEFAULT 'pending'::character varying,
    approved_by integer,
    approved_at timestamp without time zone,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT expenses_approval_status_check CHECK (((approval_status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[]))),
    CONSTRAINT expenses_payment_method_check CHECK (((payment_method)::text = ANY ((ARRAY['cash'::character varying, 'card'::character varying, 'transfer'::character varying])::text[])))
);


ALTER TABLE public.expenses OWNER TO akinadmin;

--
-- Name: expenses_expense_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.expenses_expense_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.expenses_expense_id_seq OWNER TO akinadmin;

--
-- Name: expenses_expense_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.expenses_expense_id_seq OWNED BY public.expenses.expense_id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.failed_jobs (
    failed_job_id integer NOT NULL,
    queue_name character varying(100),
    job_type character varying(100),
    payload jsonb,
    exception text,
    failed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.failed_jobs OWNER TO akinadmin;

--
-- Name: failed_jobs_failed_job_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.failed_jobs_failed_job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_failed_job_id_seq OWNER TO akinadmin;

--
-- Name: failed_jobs_failed_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.failed_jobs_failed_job_id_seq OWNED BY public.failed_jobs.failed_job_id;


--
-- Name: fault_codes; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.fault_codes (
    code_id integer NOT NULL,
    code character varying(20) NOT NULL,
    device_type character varying(100),
    description text,
    common_causes text,
    recommended_parts jsonb,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.fault_codes OWNER TO akinadmin;

--
-- Name: fault_codes_code_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.fault_codes_code_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fault_codes_code_id_seq OWNER TO akinadmin;

--
-- Name: fault_codes_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.fault_codes_code_id_seq OWNED BY public.fault_codes.code_id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.files (
    file_id integer NOT NULL,
    entity_type character varying(50),
    entity_id integer,
    file_name character varying(255) NOT NULL,
    original_name character varying(255),
    file_path character varying(500),
    file_type character varying(50),
    category character varying(50),
    mime_type character varying(100),
    size bigint,
    uploaded_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.files OWNER TO akinadmin;

--
-- Name: files_file_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.files_file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.files_file_id_seq OWNER TO akinadmin;

--
-- Name: files_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.files_file_id_seq OWNED BY public.files.file_id;


--
-- Name: holidays; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.holidays (
    holiday_id integer NOT NULL,
    holiday_name character varying(200) NOT NULL,
    holiday_date date NOT NULL,
    holiday_type character varying(20),
    is_recurring boolean DEFAULT false,
    description text,
    CONSTRAINT holidays_holiday_type_check CHECK (((holiday_type)::text = ANY ((ARRAY['national'::character varying, 'religious'::character varying, 'company'::character varying])::text[])))
);


ALTER TABLE public.holidays OWNER TO akinadmin;

--
-- Name: holidays_holiday_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.holidays_holiday_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.holidays_holiday_id_seq OWNER TO akinadmin;

--
-- Name: holidays_holiday_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.holidays_holiday_id_seq OWNED BY public.holidays.holiday_id;


--
-- Name: installment_plans; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.installment_plans (
    plan_id integer NOT NULL,
    invoice_id integer,
    total_installments integer NOT NULL,
    installment_amount numeric(10,2),
    interest_rate numeric(5,2),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.installment_plans OWNER TO akinadmin;

--
-- Name: installment_plans_plan_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.installment_plans_plan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.installment_plans_plan_id_seq OWNER TO akinadmin;

--
-- Name: installment_plans_plan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.installment_plans_plan_id_seq OWNED BY public.installment_plans.plan_id;


--
-- Name: installments; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.installments (
    installment_id integer NOT NULL,
    plan_id integer,
    installment_number integer NOT NULL,
    due_date date NOT NULL,
    amount numeric(10,2) NOT NULL,
    paid_amount numeric(10,2) DEFAULT 0,
    payment_date date,
    status character varying(20) DEFAULT 'pending'::character varying,
    CONSTRAINT installments_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'paid'::character varying, 'overdue'::character varying])::text[])))
);


ALTER TABLE public.installments OWNER TO akinadmin;

--
-- Name: installments_installment_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.installments_installment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.installments_installment_id_seq OWNER TO akinadmin;

--
-- Name: installments_installment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.installments_installment_id_seq OWNED BY public.installments.installment_id;


--
-- Name: insurance_policies; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.insurance_policies (
    policy_id integer NOT NULL,
    policy_type character varying(50),
    policy_number character varying(100) NOT NULL,
    insurance_company character varying(200),
    insured_type character varying(20),
    insured_id integer,
    coverage_amount numeric(15,2),
    premium_amount numeric(10,2),
    premium_frequency character varying(20),
    start_date date NOT NULL,
    end_date date NOT NULL,
    renewal_date date,
    status character varying(20) DEFAULT 'active'::character varying,
    file_id integer,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT insurance_policies_insured_type_check CHECK (((insured_type)::text = ANY ((ARRAY['company'::character varying, 'employee'::character varying, 'technician'::character varying, 'vehicle'::character varying, 'asset'::character varying])::text[]))),
    CONSTRAINT insurance_policies_policy_type_check CHECK (((policy_type)::text = ANY ((ARRAY['health'::character varying, 'life'::character varying, 'vehicle'::character varying, 'property'::character varying, 'liability'::character varying, 'other'::character varying])::text[]))),
    CONSTRAINT insurance_policies_premium_frequency_check CHECK (((premium_frequency)::text = ANY ((ARRAY['monthly'::character varying, 'quarterly'::character varying, 'yearly'::character varying])::text[]))),
    CONSTRAINT insurance_policies_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'expired'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.insurance_policies OWNER TO akinadmin;

--
-- Name: insurance_policies_policy_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.insurance_policies_policy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.insurance_policies_policy_id_seq OWNER TO akinadmin;

--
-- Name: insurance_policies_policy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.insurance_policies_policy_id_seq OWNED BY public.insurance_policies.policy_id;


--
-- Name: integration_logs; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.integration_logs (
    log_id integer NOT NULL,
    integration_type character varying(50),
    request_data jsonb,
    response_data jsonb,
    status character varying(20),
    error_message text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT integration_logs_integration_type_check CHECK (((integration_type)::text = ANY ((ARRAY['e_invoice'::character varying, 'accounting'::character varying, 'maps'::character varying, 'sms'::character varying, 'email'::character varying])::text[]))),
    CONSTRAINT integration_logs_status_check CHECK (((status)::text = ANY ((ARRAY['success'::character varying, 'failed'::character varying])::text[])))
);


ALTER TABLE public.integration_logs OWNER TO akinadmin;

--
-- Name: integration_logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.integration_logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.integration_logs_log_id_seq OWNER TO akinadmin;

--
-- Name: integration_logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.integration_logs_log_id_seq OWNED BY public.integration_logs.log_id;


--
-- Name: internal_messages; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.internal_messages (
    message_id integer NOT NULL,
    sender_id integer,
    recipient_id integer,
    subject character varying(200),
    message text,
    is_read boolean DEFAULT false,
    read_at timestamp without time zone,
    parent_message_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.internal_messages OWNER TO akinadmin;

--
-- Name: internal_messages_message_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.internal_messages_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.internal_messages_message_id_seq OWNER TO akinadmin;

--
-- Name: internal_messages_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.internal_messages_message_id_seq OWNED BY public.internal_messages.message_id;


--
-- Name: inventory_adjustment_items; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.inventory_adjustment_items (
    item_id integer NOT NULL,
    adjustment_id integer,
    part_id integer,
    warehouse_id integer,
    quantity_before integer,
    quantity_after integer,
    quantity_change integer,
    unit_cost numeric(10,2),
    total_cost numeric(10,2)
);


ALTER TABLE public.inventory_adjustment_items OWNER TO akinadmin;

--
-- Name: inventory_adjustment_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.inventory_adjustment_items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventory_adjustment_items_item_id_seq OWNER TO akinadmin;

--
-- Name: inventory_adjustment_items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.inventory_adjustment_items_item_id_seq OWNED BY public.inventory_adjustment_items.item_id;


--
-- Name: inventory_adjustments; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.inventory_adjustments (
    adjustment_id integer NOT NULL,
    adjustment_date date NOT NULL,
    adjustment_type character varying(20),
    reason character varying(100),
    notes text,
    status character varying(20) DEFAULT 'pending'::character varying,
    approved_by integer,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT inventory_adjustments_adjustment_type_check CHECK (((adjustment_type)::text = ANY ((ARRAY['increase'::character varying, 'decrease'::character varying, 'correction'::character varying])::text[]))),
    CONSTRAINT inventory_adjustments_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[])))
);


ALTER TABLE public.inventory_adjustments OWNER TO akinadmin;

--
-- Name: inventory_adjustments_adjustment_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.inventory_adjustments_adjustment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventory_adjustments_adjustment_id_seq OWNER TO akinadmin;

--
-- Name: inventory_adjustments_adjustment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.inventory_adjustments_adjustment_id_seq OWNED BY public.inventory_adjustments.adjustment_id;


--
-- Name: invoice_items; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.invoice_items (
    item_id integer NOT NULL,
    invoice_id integer,
    item_type character varying(20),
    description text,
    quantity integer,
    unit_price numeric(10,2),
    tax_rate numeric(5,2),
    discount_rate numeric(5,2),
    total_price numeric(10,2),
    CONSTRAINT invoice_items_item_type_check CHECK (((item_type)::text = ANY ((ARRAY['service'::character varying, 'part'::character varying])::text[])))
);


ALTER TABLE public.invoice_items OWNER TO akinadmin;

--
-- Name: invoice_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.invoice_items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoice_items_item_id_seq OWNER TO akinadmin;

--
-- Name: invoice_items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.invoice_items_item_id_seq OWNED BY public.invoice_items.item_id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.invoices (
    invoice_id integer NOT NULL,
    invoice_number character varying(50) NOT NULL,
    invoice_type character varying(20),
    customer_id integer,
    service_id integer,
    invoice_date date NOT NULL,
    due_date date,
    subtotal numeric(10,2),
    tax_amount numeric(10,2),
    discount_amount numeric(10,2),
    total_amount numeric(10,2),
    payment_status character varying(20) DEFAULT 'unpaid'::character varying,
    paid_amount numeric(10,2) DEFAULT 0,
    notes text,
    e_invoice_uuid character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    currency character varying(3) DEFAULT 'TRY'::character varying,
    exchange_rate numeric(10,4) DEFAULT 1,
    payment_terms character varying(100),
    bank_account_id integer,
    late_fee numeric(10,2),
    interest_rate numeric(5,2),
    reminder_sent_count integer DEFAULT 0,
    last_reminder_date date,
    CONSTRAINT invoices_invoice_type_check CHECK (((invoice_type)::text = ANY ((ARRAY['service'::character varying, 'sales'::character varying, 'contract'::character varying])::text[]))),
    CONSTRAINT invoices_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['unpaid'::character varying, 'partial'::character varying, 'paid'::character varying])::text[])))
);


ALTER TABLE public.invoices OWNER TO akinadmin;

--
-- Name: invoices_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.invoices_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoices_invoice_id_seq OWNER TO akinadmin;

--
-- Name: invoices_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.invoices_invoice_id_seq OWNED BY public.invoices.invoice_id;


--
-- Name: ip_whitelist; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.ip_whitelist (
    whitelist_id integer NOT NULL,
    ip_address character varying(45) NOT NULL,
    description text,
    is_active boolean DEFAULT true,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ip_whitelist OWNER TO akinadmin;

--
-- Name: ip_whitelist_whitelist_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.ip_whitelist_whitelist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ip_whitelist_whitelist_id_seq OWNER TO akinadmin;

--
-- Name: ip_whitelist_whitelist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.ip_whitelist_whitelist_id_seq OWNED BY public.ip_whitelist.whitelist_id;


--
-- Name: kpi_metrics; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.kpi_metrics (
    metric_id integer NOT NULL,
    metric_name character varying(100) NOT NULL,
    metric_type character varying(50),
    target_value numeric(10,2),
    actual_value numeric(10,2),
    period_month integer,
    period_year integer,
    calculated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT kpi_metrics_period_month_check CHECK (((period_month >= 1) AND (period_month <= 12)))
);


ALTER TABLE public.kpi_metrics OWNER TO akinadmin;

--
-- Name: kpi_metrics_metric_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.kpi_metrics_metric_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kpi_metrics_metric_id_seq OWNER TO akinadmin;

--
-- Name: kpi_metrics_metric_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.kpi_metrics_metric_id_seq OWNED BY public.kpi_metrics.metric_id;


--
-- Name: leaves; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.leaves (
    leave_id integer NOT NULL,
    employee_id integer,
    technician_id integer,
    leave_type character varying(50),
    start_date date NOT NULL,
    end_date date NOT NULL,
    total_days integer,
    reason text,
    status character varying(20) DEFAULT 'pending'::character varying,
    approved_by integer,
    approved_at timestamp without time zone,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT leaves_leave_type_check CHECK (((leave_type)::text = ANY ((ARRAY['annual'::character varying, 'sick'::character varying, 'unpaid'::character varying, 'maternity'::character varying, 'paternity'::character varying, 'bereavement'::character varying, 'other'::character varying])::text[]))),
    CONSTRAINT leaves_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.leaves OWNER TO akinadmin;

--
-- Name: leaves_leave_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.leaves_leave_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leaves_leave_id_seq OWNER TO akinadmin;

--
-- Name: leaves_leave_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.leaves_leave_id_seq OWNED BY public.leaves.leave_id;


--
-- Name: licenses; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.licenses (
    license_id integer NOT NULL,
    license_type character varying(50),
    license_name character varying(200) NOT NULL,
    license_number character varying(100),
    issuing_authority character varying(200),
    issue_date date,
    expiry_date date,
    renewal_date date,
    cost numeric(10,2),
    assigned_to_type character varying(20),
    assigned_to_id integer,
    status character varying(20) DEFAULT 'active'::character varying,
    file_id integer,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT licenses_assigned_to_type_check CHECK (((assigned_to_type)::text = ANY ((ARRAY['company'::character varying, 'employee'::character varying, 'technician'::character varying, 'vehicle'::character varying])::text[]))),
    CONSTRAINT licenses_license_type_check CHECK (((license_type)::text = ANY ((ARRAY['business'::character varying, 'software'::character varying, 'vehicle'::character varying, 'professional'::character varying, 'other'::character varying])::text[]))),
    CONSTRAINT licenses_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'expired'::character varying, 'suspended'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.licenses OWNER TO akinadmin;

--
-- Name: licenses_license_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.licenses_license_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.licenses_license_id_seq OWNER TO akinadmin;

--
-- Name: licenses_license_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.licenses_license_id_seq OWNED BY public.licenses.license_id;


--
-- Name: login_attempts; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.login_attempts (
    attempt_id integer NOT NULL,
    username character varying(100),
    ip_address character varying(45),
    user_agent text,
    success boolean DEFAULT false,
    failure_reason character varying(100),
    attempted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.login_attempts OWNER TO akinadmin;

--
-- Name: login_attempts_attempt_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.login_attempts_attempt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.login_attempts_attempt_id_seq OWNER TO akinadmin;

--
-- Name: login_attempts_attempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.login_attempts_attempt_id_seq OWNED BY public.login_attempts.attempt_id;


--
-- Name: maintenance_schedules; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.maintenance_schedules (
    schedule_id integer NOT NULL,
    device_id integer,
    frequency_type character varying(20),
    frequency_value integer,
    last_service_date date,
    next_service_date date,
    auto_create_appointment boolean DEFAULT true,
    notification_days_before integer DEFAULT 7,
    status character varying(20) DEFAULT 'active'::character varying,
    CONSTRAINT maintenance_schedules_frequency_type_check CHECK (((frequency_type)::text = ANY ((ARRAY['monthly'::character varying, 'quarterly'::character varying, 'yearly'::character varying])::text[]))),
    CONSTRAINT maintenance_schedules_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.maintenance_schedules OWNER TO akinadmin;

--
-- Name: maintenance_schedules_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.maintenance_schedules_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.maintenance_schedules_schedule_id_seq OWNER TO akinadmin;

--
-- Name: maintenance_schedules_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.maintenance_schedules_schedule_id_seq OWNED BY public.maintenance_schedules.schedule_id;


--
-- Name: marketing_messages; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.marketing_messages (
    message_id integer NOT NULL,
    campaign_id integer,
    message_type character varying(20),
    subject character varying(200),
    content text,
    target_segment character varying(100),
    scheduled_date timestamp without time zone,
    sent_date timestamp without time zone,
    recipient_count integer,
    status character varying(20) DEFAULT 'draft'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT marketing_messages_message_type_check CHECK (((message_type)::text = ANY ((ARRAY['sms'::character varying, 'email'::character varying, 'whatsapp'::character varying])::text[]))),
    CONSTRAINT marketing_messages_status_check CHECK (((status)::text = ANY ((ARRAY['draft'::character varying, 'scheduled'::character varying, 'sent'::character varying])::text[])))
);


ALTER TABLE public.marketing_messages OWNER TO akinadmin;

--
-- Name: marketing_messages_message_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.marketing_messages_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.marketing_messages_message_id_seq OWNER TO akinadmin;

--
-- Name: marketing_messages_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.marketing_messages_message_id_seq OWNED BY public.marketing_messages.message_id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.migrations (
    migration_id integer NOT NULL,
    migration_name character varying(255) NOT NULL,
    batch integer,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.migrations OWNER TO akinadmin;

--
-- Name: migrations_migration_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.migrations_migration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_migration_id_seq OWNER TO akinadmin;

--
-- Name: migrations_migration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.migrations_migration_id_seq OWNED BY public.migrations.migration_id;


--
-- Name: notification_preferences; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.notification_preferences (
    preference_id integer NOT NULL,
    user_id integer,
    email_enabled boolean DEFAULT true,
    sms_enabled boolean DEFAULT true,
    push_enabled boolean DEFAULT true,
    appointment_reminders boolean DEFAULT true,
    payment_reminders boolean DEFAULT true,
    maintenance_reminders boolean DEFAULT true,
    marketing_messages boolean DEFAULT false,
    system_notifications boolean DEFAULT true
);


ALTER TABLE public.notification_preferences OWNER TO akinadmin;

--
-- Name: notification_preferences_preference_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.notification_preferences_preference_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_preferences_preference_id_seq OWNER TO akinadmin;

--
-- Name: notification_preferences_preference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.notification_preferences_preference_id_seq OWNED BY public.notification_preferences.preference_id;


--
-- Name: notification_templates; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.notification_templates (
    template_id integer NOT NULL,
    template_name character varying(100) NOT NULL,
    template_type character varying(20),
    event_trigger character varying(100),
    subject character varying(200),
    body text,
    variables jsonb,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT notification_templates_template_type_check CHECK (((template_type)::text = ANY ((ARRAY['sms'::character varying, 'email'::character varying, 'push'::character varying, 'whatsapp'::character varying])::text[])))
);


ALTER TABLE public.notification_templates OWNER TO akinadmin;

--
-- Name: notification_templates_template_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.notification_templates_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_templates_template_id_seq OWNER TO akinadmin;

--
-- Name: notification_templates_template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.notification_templates_template_id_seq OWNED BY public.notification_templates.template_id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.notifications (
    notification_id integer NOT NULL,
    user_id integer,
    notification_type character varying(50),
    title character varying(200),
    message text,
    is_read boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT notifications_notification_type_check CHECK (((notification_type)::text = ANY ((ARRAY['appointment'::character varying, 'payment'::character varying, 'maintenance'::character varying])::text[])))
);


ALTER TABLE public.notifications OWNER TO akinadmin;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.notifications_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_notification_id_seq OWNER TO akinadmin;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.notifications_notification_id_seq OWNED BY public.notifications.notification_id;


--
-- Name: overtime; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.overtime (
    overtime_id integer NOT NULL,
    employee_id integer,
    technician_id integer,
    overtime_date date NOT NULL,
    start_time time without time zone,
    end_time time without time zone,
    total_hours numeric(5,2),
    overtime_rate numeric(5,2),
    amount numeric(10,2),
    status character varying(20) DEFAULT 'pending'::character varying,
    approved_by integer,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT overtime_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying, 'paid'::character varying])::text[])))
);


ALTER TABLE public.overtime OWNER TO akinadmin;

--
-- Name: overtime_overtime_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.overtime_overtime_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.overtime_overtime_id_seq OWNER TO akinadmin;

--
-- Name: overtime_overtime_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.overtime_overtime_id_seq OWNED BY public.overtime.overtime_id;


--
-- Name: part_photos; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.part_photos (
    photo_id integer NOT NULL,
    part_id integer,
    file_id integer,
    photo_type character varying(20),
    is_primary boolean DEFAULT false,
    display_order integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT part_photos_photo_type_check CHECK (((photo_type)::text = ANY ((ARRAY['product'::character varying, 'packaging'::character varying, 'installation'::character varying, 'damage'::character varying])::text[])))
);


ALTER TABLE public.part_photos OWNER TO akinadmin;

--
-- Name: part_photos_photo_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.part_photos_photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.part_photos_photo_id_seq OWNER TO akinadmin;

--
-- Name: part_photos_photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.part_photos_photo_id_seq OWNED BY public.part_photos.photo_id;


--
-- Name: part_returns; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.part_returns (
    return_id integer NOT NULL,
    service_part_id integer,
    return_date date NOT NULL,
    reason text,
    refund_amount numeric(10,2),
    status character varying(20) DEFAULT 'pending'::character varying,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT part_returns_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'completed'::character varying, 'rejected'::character varying])::text[])))
);


ALTER TABLE public.part_returns OWNER TO akinadmin;

--
-- Name: part_returns_return_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.part_returns_return_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.part_returns_return_id_seq OWNER TO akinadmin;

--
-- Name: part_returns_return_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.part_returns_return_id_seq OWNED BY public.part_returns.return_id;


--
-- Name: part_suppliers; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.part_suppliers (
    part_supplier_id integer NOT NULL,
    part_id integer,
    supplier_id integer,
    supplier_part_code character varying(100),
    unit_price numeric(10,2),
    minimum_order_quantity integer,
    lead_time_days integer,
    is_preferred boolean DEFAULT false,
    last_purchase_date date,
    last_purchase_price numeric(10,2),
    notes text
);


ALTER TABLE public.part_suppliers OWNER TO akinadmin;

--
-- Name: part_suppliers_part_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.part_suppliers_part_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.part_suppliers_part_supplier_id_seq OWNER TO akinadmin;

--
-- Name: part_suppliers_part_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.part_suppliers_part_supplier_id_seq OWNED BY public.part_suppliers.part_supplier_id;


--
-- Name: partner_current_accounts; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.partner_current_accounts (
    account_id integer NOT NULL,
    partner_id integer,
    current_balance numeric(15,2) DEFAULT 0,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.partner_current_accounts OWNER TO akinadmin;

--
-- Name: partner_current_accounts_account_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.partner_current_accounts_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partner_current_accounts_account_id_seq OWNER TO akinadmin;

--
-- Name: partner_current_accounts_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.partner_current_accounts_account_id_seq OWNED BY public.partner_current_accounts.account_id;


--
-- Name: partner_transactions; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.partner_transactions (
    transaction_id integer NOT NULL,
    partner_id integer,
    transaction_type character varying(20),
    transaction_date date NOT NULL,
    amount numeric(15,2) NOT NULL,
    account_id integer,
    description text,
    approved_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT partner_transactions_transaction_type_check CHECK (((transaction_type)::text = ANY ((ARRAY['investment'::character varying, 'withdrawal'::character varying, 'profit_share'::character varying])::text[])))
);


ALTER TABLE public.partner_transactions OWNER TO akinadmin;

--
-- Name: partner_transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.partner_transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partner_transactions_transaction_id_seq OWNER TO akinadmin;

--
-- Name: partner_transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.partner_transactions_transaction_id_seq OWNED BY public.partner_transactions.transaction_id;


--
-- Name: partners; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.partners (
    partner_id integer NOT NULL,
    partner_name character varying(100) NOT NULL,
    tax_number character varying(50),
    phone character varying(20),
    email character varying(100),
    share_percentage numeric(5,2),
    investment_amount numeric(15,2),
    join_date date,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT partners_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.partners OWNER TO akinadmin;

--
-- Name: partners_partner_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.partners_partner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partners_partner_id_seq OWNER TO akinadmin;

--
-- Name: partners_partner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.partners_partner_id_seq OWNED BY public.partners.partner_id;


--
-- Name: parts; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.parts (
    part_id integer NOT NULL,
    part_code character varying(50) NOT NULL,
    part_name character varying(200) NOT NULL,
    category character varying(100),
    brand character varying(100),
    model_compatibility text,
    unit character varying(20),
    unit_price numeric(10,2),
    sale_price numeric(10,2),
    minimum_stock integer DEFAULT 0,
    reorder_quantity integer DEFAULT 0,
    supplier_id integer,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    barcode character varying(100),
    sku character varying(100),
    weight numeric(10,3),
    dimensions character varying(100),
    location character varying(100),
    bin_number character varying(50),
    shelf_number character varying(50),
    critical boolean DEFAULT false,
    lead_time integer,
    last_purchase_date date,
    last_purchase_price numeric(10,2),
    average_cost numeric(10,2),
    image_url character varying(500),
    warranty_period integer DEFAULT 12,
    CONSTRAINT parts_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'discontinued'::character varying])::text[])))
);


ALTER TABLE public.parts OWNER TO akinadmin;

--
-- Name: parts_part_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.parts_part_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.parts_part_id_seq OWNER TO akinadmin;

--
-- Name: parts_part_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.parts_part_id_seq OWNED BY public.parts.part_id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.password_resets (
    reset_id integer NOT NULL,
    user_id integer,
    reset_token character varying(255) NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    used_at timestamp without time zone,
    ip_address character varying(45),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.password_resets OWNER TO akinadmin;

--
-- Name: password_resets_reset_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.password_resets_reset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.password_resets_reset_id_seq OWNER TO akinadmin;

--
-- Name: password_resets_reset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.password_resets_reset_id_seq OWNED BY public.password_resets.reset_id;


--
-- Name: payment_plan_installments; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.payment_plan_installments (
    installment_id integer NOT NULL,
    plan_id integer,
    installment_number integer NOT NULL,
    due_date date NOT NULL,
    amount numeric(10,2) NOT NULL,
    paid_date date,
    status character varying(20) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT payment_plan_installments_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'paid'::character varying, 'overdue'::character varying])::text[])))
);


ALTER TABLE public.payment_plan_installments OWNER TO akinadmin;

--
-- Name: payment_plan_installments_installment_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.payment_plan_installments_installment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_plan_installments_installment_id_seq OWNER TO akinadmin;

--
-- Name: payment_plan_installments_installment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.payment_plan_installments_installment_id_seq OWNED BY public.payment_plan_installments.installment_id;


--
-- Name: payment_plans; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.payment_plans (
    plan_id integer NOT NULL,
    service_id integer,
    customer_id integer,
    total_amount numeric(10,2) NOT NULL,
    installment_count integer NOT NULL,
    installment_amount numeric(10,2),
    paid_installments integer DEFAULT 0,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT payment_plans_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'completed'::character varying, 'defaulted'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.payment_plans OWNER TO akinadmin;

--
-- Name: payment_plans_plan_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.payment_plans_plan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_plans_plan_id_seq OWNER TO akinadmin;

--
-- Name: payment_plans_plan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.payment_plans_plan_id_seq OWNED BY public.payment_plans.plan_id;


--
-- Name: payment_terms; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.payment_terms (
    term_id integer NOT NULL,
    term_name character varying(100) NOT NULL,
    days integer NOT NULL,
    discount_percentage numeric(5,2),
    discount_days integer,
    description text,
    is_active boolean DEFAULT true
);


ALTER TABLE public.payment_terms OWNER TO akinadmin;

--
-- Name: payment_terms_term_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.payment_terms_term_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_terms_term_id_seq OWNER TO akinadmin;

--
-- Name: payment_terms_term_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.payment_terms_term_id_seq OWNED BY public.payment_terms.term_id;


--
-- Name: payments_received; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.payments_received (
    payment_id integer NOT NULL,
    invoice_id integer,
    customer_id integer,
    payment_date date NOT NULL,
    payment_method character varying(20),
    amount numeric(10,2) NOT NULL,
    account_id integer,
    reference_number character varying(100),
    notes text,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT payments_received_payment_method_check CHECK (((payment_method)::text = ANY ((ARRAY['cash'::character varying, 'card'::character varying, 'transfer'::character varying, 'check'::character varying])::text[])))
);


ALTER TABLE public.payments_received OWNER TO akinadmin;

--
-- Name: payments_received_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.payments_received_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_received_payment_id_seq OWNER TO akinadmin;

--
-- Name: payments_received_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.payments_received_payment_id_seq OWNED BY public.payments_received.payment_id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.permissions (
    permission_id integer NOT NULL,
    permission_name character varying(100) NOT NULL,
    module character varying(50),
    action character varying(50),
    description text
);


ALTER TABLE public.permissions OWNER TO akinadmin;

--
-- Name: permissions_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.permissions_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_permission_id_seq OWNER TO akinadmin;

--
-- Name: permissions_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.permissions_permission_id_seq OWNED BY public.permissions.permission_id;


--
-- Name: petty_cash; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.petty_cash (
    transaction_id integer NOT NULL,
    transaction_date date NOT NULL,
    transaction_type character varying(20),
    amount numeric(10,2) NOT NULL,
    category character varying(100),
    description text,
    receipt_number character varying(50),
    handled_by integer,
    approved_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT petty_cash_transaction_type_check CHECK (((transaction_type)::text = ANY ((ARRAY['in'::character varying, 'out'::character varying])::text[])))
);


ALTER TABLE public.petty_cash OWNER TO akinadmin;

--
-- Name: petty_cash_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.petty_cash_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.petty_cash_transaction_id_seq OWNER TO akinadmin;

--
-- Name: petty_cash_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.petty_cash_transaction_id_seq OWNED BY public.petty_cash.transaction_id;


--
-- Name: price_history; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.price_history (
    history_id integer NOT NULL,
    part_id integer,
    old_price numeric(10,2),
    new_price numeric(10,2),
    change_date date,
    changed_by integer,
    reason text
);


ALTER TABLE public.price_history OWNER TO akinadmin;

--
-- Name: price_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.price_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.price_history_history_id_seq OWNER TO akinadmin;

--
-- Name: price_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.price_history_history_id_seq OWNED BY public.price_history.history_id;


--
-- Name: price_list_items; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.price_list_items (
    item_id integer NOT NULL,
    price_list_id integer,
    part_id integer,
    price numeric(10,2),
    discount_percentage numeric(5,2)
);


ALTER TABLE public.price_list_items OWNER TO akinadmin;

--
-- Name: price_list_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.price_list_items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.price_list_items_item_id_seq OWNER TO akinadmin;

--
-- Name: price_list_items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.price_list_items_item_id_seq OWNED BY public.price_list_items.item_id;


--
-- Name: price_lists; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.price_lists (
    price_list_id integer NOT NULL,
    list_name character varying(100) NOT NULL,
    valid_from date,
    valid_until date,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.price_lists OWNER TO akinadmin;

--
-- Name: price_lists_price_list_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.price_lists_price_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.price_lists_price_list_id_seq OWNER TO akinadmin;

--
-- Name: price_lists_price_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.price_lists_price_list_id_seq OWNED BY public.price_lists.price_list_id;


--
-- Name: promissory_notes; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.promissory_notes (
    note_id integer NOT NULL,
    note_type character varying(20),
    note_number character varying(50) NOT NULL,
    amount numeric(10,2) NOT NULL,
    issue_date date,
    due_date date NOT NULL,
    customer_id integer,
    supplier_id integer,
    endorsement_count integer DEFAULT 0,
    status character varying(20) DEFAULT 'portfolio'::character varying,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT promissory_notes_note_type_check CHECK (((note_type)::text = ANY ((ARRAY['received'::character varying, 'issued'::character varying])::text[]))),
    CONSTRAINT promissory_notes_status_check CHECK (((status)::text = ANY ((ARRAY['portfolio'::character varying, 'bank'::character varying, 'collected'::character varying, 'protested'::character varying])::text[])))
);


ALTER TABLE public.promissory_notes OWNER TO akinadmin;

--
-- Name: promissory_notes_note_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.promissory_notes_note_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promissory_notes_note_id_seq OWNER TO akinadmin;

--
-- Name: promissory_notes_note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.promissory_notes_note_id_seq OWNED BY public.promissory_notes.note_id;


--
-- Name: purchase_order_items; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.purchase_order_items (
    item_id integer NOT NULL,
    order_id integer,
    part_id integer,
    quantity integer NOT NULL,
    unit_price numeric(10,2),
    total_price numeric(10,2)
);


ALTER TABLE public.purchase_order_items OWNER TO akinadmin;

--
-- Name: purchase_order_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.purchase_order_items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_order_items_item_id_seq OWNER TO akinadmin;

--
-- Name: purchase_order_items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.purchase_order_items_item_id_seq OWNED BY public.purchase_order_items.item_id;


--
-- Name: purchase_orders; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.purchase_orders (
    order_id integer NOT NULL,
    supplier_id integer,
    order_date date NOT NULL,
    expected_delivery_date date,
    actual_delivery_date date,
    total_amount numeric(10,2),
    status character varying(20) DEFAULT 'pending'::character varying,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT purchase_orders_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'ordered'::character varying, 'received'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.purchase_orders OWNER TO akinadmin;

--
-- Name: purchase_orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.purchase_orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_orders_order_id_seq OWNER TO akinadmin;

--
-- Name: purchase_orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.purchase_orders_order_id_seq OWNED BY public.purchase_orders.order_id;


--
-- Name: queue_jobs; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.queue_jobs (
    job_id integer NOT NULL,
    queue_name character varying(100),
    job_type character varying(100),
    payload jsonb,
    attempts integer DEFAULT 0,
    max_attempts integer DEFAULT 3,
    status character varying(20) DEFAULT 'pending'::character varying,
    available_at timestamp without time zone,
    started_at timestamp without time zone,
    completed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT queue_jobs_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'processing'::character varying, 'completed'::character varying, 'failed'::character varying])::text[])))
);


ALTER TABLE public.queue_jobs OWNER TO akinadmin;

--
-- Name: queue_jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.queue_jobs_job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.queue_jobs_job_id_seq OWNER TO akinadmin;

--
-- Name: queue_jobs_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.queue_jobs_job_id_seq OWNED BY public.queue_jobs.job_id;


--
-- Name: quotation_items; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.quotation_items (
    item_id integer NOT NULL,
    quotation_id integer,
    item_type character varying(20),
    description text,
    quantity integer,
    unit_price numeric(10,2),
    tax_rate numeric(5,2),
    discount_rate numeric(5,2),
    total_price numeric(10,2),
    CONSTRAINT quotation_items_item_type_check CHECK (((item_type)::text = ANY ((ARRAY['service'::character varying, 'part'::character varying, 'labor'::character varying])::text[])))
);


ALTER TABLE public.quotation_items OWNER TO akinadmin;

--
-- Name: quotation_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.quotation_items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quotation_items_item_id_seq OWNER TO akinadmin;

--
-- Name: quotation_items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.quotation_items_item_id_seq OWNED BY public.quotation_items.item_id;


--
-- Name: quotations; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.quotations (
    quotation_id integer NOT NULL,
    quotation_number character varying(50) NOT NULL,
    customer_id integer,
    device_id integer,
    quotation_date date NOT NULL,
    valid_until date,
    subtotal numeric(10,2),
    tax_amount numeric(10,2),
    discount_amount numeric(10,2),
    total_amount numeric(10,2),
    status character varying(20) DEFAULT 'draft'::character varying,
    notes text,
    terms_conditions text,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    converted_to_invoice_id integer,
    CONSTRAINT quotations_status_check CHECK (((status)::text = ANY ((ARRAY['draft'::character varying, 'sent'::character varying, 'accepted'::character varying, 'rejected'::character varying, 'expired'::character varying, 'converted'::character varying])::text[])))
);


ALTER TABLE public.quotations OWNER TO akinadmin;

--
-- Name: quotations_quotation_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.quotations_quotation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quotations_quotation_id_seq OWNER TO akinadmin;

--
-- Name: quotations_quotation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.quotations_quotation_id_seq OWNED BY public.quotations.quotation_id;


--
-- Name: recurring_invoices; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.recurring_invoices (
    recurring_invoice_id integer NOT NULL,
    customer_id integer,
    contract_id integer,
    frequency character varying(20),
    start_date date NOT NULL,
    end_date date,
    next_invoice_date date,
    last_invoice_date date,
    invoice_template jsonb,
    auto_send boolean DEFAULT false,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT recurring_invoices_frequency_check CHECK (((frequency)::text = ANY ((ARRAY['daily'::character varying, 'weekly'::character varying, 'monthly'::character varying, 'quarterly'::character varying, 'yearly'::character varying])::text[]))),
    CONSTRAINT recurring_invoices_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'paused'::character varying, 'completed'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.recurring_invoices OWNER TO akinadmin;

--
-- Name: recurring_invoices_recurring_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.recurring_invoices_recurring_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recurring_invoices_recurring_invoice_id_seq OWNER TO akinadmin;

--
-- Name: recurring_invoices_recurring_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.recurring_invoices_recurring_invoice_id_seq OWNED BY public.recurring_invoices.recurring_invoice_id;


--
-- Name: referrals; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.referrals (
    referral_id integer NOT NULL,
    referrer_customer_id integer,
    referred_customer_id integer,
    referral_date date NOT NULL,
    first_service_date date,
    reward_type character varying(20),
    reward_amount numeric(10,2),
    reward_status character varying(20) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT referrals_reward_status_check CHECK (((reward_status)::text = ANY ((ARRAY['pending'::character varying, 'given'::character varying])::text[]))),
    CONSTRAINT referrals_reward_type_check CHECK (((reward_type)::text = ANY ((ARRAY['discount'::character varying, 'cash'::character varying, 'points'::character varying])::text[])))
);


ALTER TABLE public.referrals OWNER TO akinadmin;

--
-- Name: referrals_referral_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.referrals_referral_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referrals_referral_id_seq OWNER TO akinadmin;

--
-- Name: referrals_referral_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.referrals_referral_id_seq OWNED BY public.referrals.referral_id;


--
-- Name: reminders; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.reminders (
    reminder_id integer NOT NULL,
    reminder_type character varying(50),
    entity_type character varying(50),
    entity_id integer,
    reminder_date date NOT NULL,
    message text,
    status character varying(20) DEFAULT 'pending'::character varying,
    sent_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reminders_reminder_type_check CHECK (((reminder_type)::text = ANY ((ARRAY['maintenance'::character varying, 'payment'::character varying, 'contract_renewal'::character varying, 'warranty_expiry'::character varying])::text[]))),
    CONSTRAINT reminders_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'sent'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.reminders OWNER TO akinadmin;

--
-- Name: reminders_reminder_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.reminders_reminder_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reminders_reminder_id_seq OWNER TO akinadmin;

--
-- Name: reminders_reminder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.reminders_reminder_id_seq OWNED BY public.reminders.reminder_id;


--
-- Name: report_schedules; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.report_schedules (
    schedule_id integer NOT NULL,
    report_name character varying(200) NOT NULL,
    report_type character varying(50),
    frequency character varying(20),
    schedule_time time without time zone,
    schedule_day integer,
    recipients jsonb,
    parameters jsonb,
    format character varying(20),
    is_active boolean DEFAULT true,
    last_run_at timestamp without time zone,
    next_run_at timestamp without time zone,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT report_schedules_format_check CHECK (((format)::text = ANY ((ARRAY['pdf'::character varying, 'excel'::character varying, 'csv'::character varying])::text[]))),
    CONSTRAINT report_schedules_frequency_check CHECK (((frequency)::text = ANY ((ARRAY['daily'::character varying, 'weekly'::character varying, 'monthly'::character varying, 'quarterly'::character varying, 'yearly'::character varying])::text[])))
);


ALTER TABLE public.report_schedules OWNER TO akinadmin;

--
-- Name: report_schedules_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.report_schedules_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.report_schedules_schedule_id_seq OWNER TO akinadmin;

--
-- Name: report_schedules_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.report_schedules_schedule_id_seq OWNED BY public.report_schedules.schedule_id;


--
-- Name: return_request_items; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.return_request_items (
    item_id integer NOT NULL,
    return_id integer,
    part_id integer,
    quantity integer NOT NULL,
    unit_price numeric(10,2),
    total_price numeric(10,2),
    condition character varying(20),
    CONSTRAINT return_request_items_condition_check CHECK (((condition)::text = ANY ((ARRAY['new'::character varying, 'used'::character varying, 'damaged'::character varying])::text[])))
);


ALTER TABLE public.return_request_items OWNER TO akinadmin;

--
-- Name: return_request_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.return_request_items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.return_request_items_item_id_seq OWNER TO akinadmin;

--
-- Name: return_request_items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.return_request_items_item_id_seq OWNED BY public.return_request_items.item_id;


--
-- Name: return_requests; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.return_requests (
    return_id integer NOT NULL,
    return_number character varying(50) NOT NULL,
    invoice_id integer,
    customer_id integer,
    return_date date NOT NULL,
    return_reason character varying(100),
    description text,
    status character varying(20) DEFAULT 'pending'::character varying,
    refund_amount numeric(10,2),
    refund_method character varying(20),
    approved_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT return_requests_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying, 'completed'::character varying])::text[])))
);


ALTER TABLE public.return_requests OWNER TO akinadmin;

--
-- Name: return_requests_return_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.return_requests_return_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.return_requests_return_id_seq OWNER TO akinadmin;

--
-- Name: return_requests_return_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.return_requests_return_id_seq OWNED BY public.return_requests.return_id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.role_permissions (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.role_permissions OWNER TO akinadmin;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name character varying(50) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.roles OWNER TO akinadmin;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_role_id_seq OWNER TO akinadmin;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: route_stops; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.route_stops (
    stop_id integer NOT NULL,
    route_id integer,
    appointment_id integer,
    stop_order integer NOT NULL,
    estimated_arrival time without time zone,
    actual_arrival time without time zone,
    estimated_departure time without time zone,
    actual_departure time without time zone,
    latitude numeric(10,8),
    longitude numeric(11,8),
    status character varying(20) DEFAULT 'pending'::character varying,
    CONSTRAINT route_stops_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'arrived'::character varying, 'completed'::character varying, 'skipped'::character varying])::text[])))
);


ALTER TABLE public.route_stops OWNER TO akinadmin;

--
-- Name: route_stops_stop_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.route_stops_stop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.route_stops_stop_id_seq OWNER TO akinadmin;

--
-- Name: route_stops_stop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.route_stops_stop_id_seq OWNED BY public.route_stops.stop_id;


--
-- Name: routes; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.routes (
    route_id integer NOT NULL,
    technician_id integer,
    route_date date NOT NULL,
    start_time time without time zone,
    end_time time without time zone,
    total_distance numeric(10,2),
    total_duration integer,
    status character varying(20) DEFAULT 'planned'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT routes_status_check CHECK (((status)::text = ANY ((ARRAY['planned'::character varying, 'in_progress'::character varying, 'completed'::character varying])::text[])))
);


ALTER TABLE public.routes OWNER TO akinadmin;

--
-- Name: routes_route_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.routes_route_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.routes_route_id_seq OWNER TO akinadmin;

--
-- Name: routes_route_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.routes_route_id_seq OWNED BY public.routes.route_id;


--
-- Name: salaries; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.salaries (
    salary_id integer NOT NULL,
    employee_id integer,
    period_month integer,
    period_year integer,
    base_salary numeric(10,2),
    bonus numeric(10,2) DEFAULT 0,
    deductions numeric(10,2) DEFAULT 0,
    net_salary numeric(10,2),
    payment_date date,
    payment_method character varying(20),
    account_id integer,
    status character varying(20) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT salaries_period_month_check CHECK (((period_month >= 1) AND (period_month <= 12))),
    CONSTRAINT salaries_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'paid'::character varying])::text[])))
);


ALTER TABLE public.salaries OWNER TO akinadmin;

--
-- Name: salaries_salary_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.salaries_salary_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.salaries_salary_id_seq OWNER TO akinadmin;

--
-- Name: salaries_salary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.salaries_salary_id_seq OWNED BY public.salaries.salary_id;


--
-- Name: saved_filters; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.saved_filters (
    filter_id integer NOT NULL,
    user_id integer,
    filter_name character varying(100) NOT NULL,
    entity_type character varying(50),
    filter_config jsonb,
    is_default boolean DEFAULT false,
    is_public boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.saved_filters OWNER TO akinadmin;

--
-- Name: saved_filters_filter_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.saved_filters_filter_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.saved_filters_filter_id_seq OWNER TO akinadmin;

--
-- Name: saved_filters_filter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.saved_filters_filter_id_seq OWNED BY public.saved_filters.filter_id;


--
-- Name: scheduled_jobs; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.scheduled_jobs (
    job_id integer NOT NULL,
    job_name character varying(100) NOT NULL,
    job_type character varying(50),
    schedule_expression character varying(100),
    last_run_at timestamp without time zone,
    next_run_at timestamp without time zone,
    status character varying(20) DEFAULT 'active'::character varying,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT scheduled_jobs_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'paused'::character varying, 'failed'::character varying])::text[])))
);


ALTER TABLE public.scheduled_jobs OWNER TO akinadmin;

--
-- Name: scheduled_jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.scheduled_jobs_job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scheduled_jobs_job_id_seq OWNER TO akinadmin;

--
-- Name: scheduled_jobs_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.scheduled_jobs_job_id_seq OWNED BY public.scheduled_jobs.job_id;


--
-- Name: scheduled_maintenance_history; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.scheduled_maintenance_history (
    history_id integer NOT NULL,
    schedule_id integer,
    appointment_id integer,
    scheduled_date date,
    completed_date date,
    status character varying(20) DEFAULT 'scheduled'::character varying,
    CONSTRAINT scheduled_maintenance_history_status_check CHECK (((status)::text = ANY ((ARRAY['scheduled'::character varying, 'completed'::character varying, 'skipped'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.scheduled_maintenance_history OWNER TO akinadmin;

--
-- Name: scheduled_maintenance_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.scheduled_maintenance_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scheduled_maintenance_history_history_id_seq OWNER TO akinadmin;

--
-- Name: scheduled_maintenance_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.scheduled_maintenance_history_history_id_seq OWNED BY public.scheduled_maintenance_history.history_id;


--
-- Name: service_area_pricing; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.service_area_pricing (
    pricing_id integer NOT NULL,
    area_id integer,
    service_type character varying(50),
    base_price numeric(10,2),
    travel_fee numeric(10,2)
);


ALTER TABLE public.service_area_pricing OWNER TO akinadmin;

--
-- Name: service_area_pricing_pricing_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.service_area_pricing_pricing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_area_pricing_pricing_id_seq OWNER TO akinadmin;

--
-- Name: service_area_pricing_pricing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.service_area_pricing_pricing_id_seq OWNED BY public.service_area_pricing.pricing_id;


--
-- Name: service_areas; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.service_areas (
    area_id integer NOT NULL,
    area_name character varying(100) NOT NULL,
    city character varying(100),
    districts jsonb,
    assigned_technician_id integer,
    is_active boolean DEFAULT true
);


ALTER TABLE public.service_areas OWNER TO akinadmin;

--
-- Name: service_areas_area_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.service_areas_area_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_areas_area_id_seq OWNER TO akinadmin;

--
-- Name: service_areas_area_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.service_areas_area_id_seq OWNED BY public.service_areas.area_id;


--
-- Name: service_checklist_items; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.service_checklist_items (
    item_id integer NOT NULL,
    template_id integer,
    item_text text NOT NULL,
    item_order integer,
    is_required boolean DEFAULT false,
    expected_value character varying(100)
);


ALTER TABLE public.service_checklist_items OWNER TO akinadmin;

--
-- Name: service_checklist_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.service_checklist_items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_checklist_items_item_id_seq OWNER TO akinadmin;

--
-- Name: service_checklist_items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.service_checklist_items_item_id_seq OWNED BY public.service_checklist_items.item_id;


--
-- Name: service_checklist_responses; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.service_checklist_responses (
    response_id integer NOT NULL,
    checklist_id integer,
    item_id integer,
    is_checked boolean DEFAULT false,
    actual_value character varying(100),
    notes text,
    checked_at timestamp without time zone
);


ALTER TABLE public.service_checklist_responses OWNER TO akinadmin;

--
-- Name: service_checklist_responses_response_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.service_checklist_responses_response_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_checklist_responses_response_id_seq OWNER TO akinadmin;

--
-- Name: service_checklist_responses_response_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.service_checklist_responses_response_id_seq OWNED BY public.service_checklist_responses.response_id;


--
-- Name: service_checklist_templates; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.service_checklist_templates (
    template_id integer NOT NULL,
    template_name character varying(200) NOT NULL,
    service_type character varying(50),
    description text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.service_checklist_templates OWNER TO akinadmin;

--
-- Name: service_checklist_templates_template_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.service_checklist_templates_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_checklist_templates_template_id_seq OWNER TO akinadmin;

--
-- Name: service_checklist_templates_template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.service_checklist_templates_template_id_seq OWNED BY public.service_checklist_templates.template_id;


--
-- Name: service_checklists; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.service_checklists (
    checklist_id integer NOT NULL,
    service_id integer,
    template_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.service_checklists OWNER TO akinadmin;

--
-- Name: service_checklists_checklist_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.service_checklists_checklist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_checklists_checklist_id_seq OWNER TO akinadmin;

--
-- Name: service_checklists_checklist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.service_checklists_checklist_id_seq OWNED BY public.service_checklists.checklist_id;


--
-- Name: service_parts; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.service_parts (
    service_part_id integer NOT NULL,
    service_id integer,
    part_id integer,
    quantity integer NOT NULL,
    unit_price numeric(10,2),
    total_price numeric(10,2),
    warranty_months integer
);


ALTER TABLE public.service_parts OWNER TO akinadmin;

--
-- Name: service_parts_service_part_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.service_parts_service_part_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_parts_service_part_id_seq OWNER TO akinadmin;

--
-- Name: service_parts_service_part_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.service_parts_service_part_id_seq OWNED BY public.service_parts.service_part_id;


--
-- Name: service_photos; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.service_photos (
    photo_id integer NOT NULL,
    service_id integer,
    file_id integer,
    photo_type character varying(20),
    category character varying(50),
    description text,
    latitude numeric(10,8),
    longitude numeric(11,8),
    taken_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    taken_by integer,
    is_customer_visible boolean DEFAULT true,
    display_order integer,
    CONSTRAINT service_photos_photo_type_check CHECK (((photo_type)::text = ANY ((ARRAY['before'::character varying, 'during'::character varying, 'after'::character varying, 'part'::character varying, 'damage'::character varying, 'repair'::character varying, 'other'::character varying])::text[])))
);


ALTER TABLE public.service_photos OWNER TO akinadmin;

--
-- Name: service_photos_photo_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.service_photos_photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_photos_photo_id_seq OWNER TO akinadmin;

--
-- Name: service_photos_photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.service_photos_photo_id_seq OWNED BY public.service_photos.photo_id;


--
-- Name: service_ratings; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.service_ratings (
    rating_id integer NOT NULL,
    service_id integer,
    overall_rating integer,
    technician_rating integer,
    quality_rating integer,
    timeliness_rating integer,
    communication_rating integer,
    cleanliness_rating integer,
    would_recommend boolean,
    feedback text,
    rated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT service_ratings_cleanliness_rating_check CHECK (((cleanliness_rating >= 1) AND (cleanliness_rating <= 5))),
    CONSTRAINT service_ratings_communication_rating_check CHECK (((communication_rating >= 1) AND (communication_rating <= 5))),
    CONSTRAINT service_ratings_overall_rating_check CHECK (((overall_rating >= 1) AND (overall_rating <= 5))),
    CONSTRAINT service_ratings_quality_rating_check CHECK (((quality_rating >= 1) AND (quality_rating <= 5))),
    CONSTRAINT service_ratings_technician_rating_check CHECK (((technician_rating >= 1) AND (technician_rating <= 5))),
    CONSTRAINT service_ratings_timeliness_rating_check CHECK (((timeliness_rating >= 1) AND (timeliness_rating <= 5)))
);


ALTER TABLE public.service_ratings OWNER TO akinadmin;

--
-- Name: service_ratings_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.service_ratings_rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_ratings_rating_id_seq OWNER TO akinadmin;

--
-- Name: service_ratings_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.service_ratings_rating_id_seq OWNED BY public.service_ratings.rating_id;


--
-- Name: service_zones; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.service_zones (
    zone_id integer NOT NULL,
    zone_name character varying(100) NOT NULL,
    cities jsonb,
    districts jsonb,
    default_technician_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.service_zones OWNER TO akinadmin;

--
-- Name: service_zones_zone_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.service_zones_zone_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_zones_zone_id_seq OWNER TO akinadmin;

--
-- Name: service_zones_zone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.service_zones_zone_id_seq OWNED BY public.service_zones.zone_id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.services (
    service_id integer NOT NULL,
    appointment_id integer,
    customer_id integer,
    device_id integer,
    technician_id integer,
    service_type character varying(50),
    service_date date,
    start_time time without time zone,
    end_time time without time zone,
    problem_description text,
    solution_description text,
    status character varying(20) DEFAULT 'pending'::character varying,
    customer_signature text,
    technician_notes text,
    customer_rating integer,
    customer_feedback text,
    total_cost numeric(10,2),
    labor_cost numeric(10,2),
    parts_cost numeric(10,2),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    completed_at timestamp without time zone,
    scheduled_date date,
    actual_date date,
    travel_time integer,
    travel_distance numeric(10,2),
    travel_cost numeric(10,2),
    discount_amount numeric(10,2),
    tax_amount numeric(10,2),
    payment_status character varying(20),
    invoice_id integer,
    warranty_work boolean DEFAULT false,
    follow_up_required boolean DEFAULT false,
    follow_up_date date,
    priority character varying(20) DEFAULT 'normal'::character varying,
    estimated_duration integer,
    before_photos text[],
    after_photos text[],
    CONSTRAINT services_customer_rating_check CHECK (((customer_rating >= 1) AND (customer_rating <= 5))),
    CONSTRAINT services_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'in_progress'::character varying, 'completed'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.services OWNER TO akinadmin;

--
-- Name: services_service_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.services_service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.services_service_id_seq OWNER TO akinadmin;

--
-- Name: services_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.services_service_id_seq OWNED BY public.services.service_id;


--
-- Name: sgk_declarations; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.sgk_declarations (
    declaration_id integer NOT NULL,
    period_month integer,
    period_year integer,
    employee_count integer,
    total_premium numeric(10,2),
    declaration_date date,
    payment_date date,
    status character varying(20) DEFAULT 'pending'::character varying,
    CONSTRAINT sgk_declarations_period_month_check CHECK (((period_month >= 1) AND (period_month <= 12))),
    CONSTRAINT sgk_declarations_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'declared'::character varying, 'paid'::character varying])::text[])))
);


ALTER TABLE public.sgk_declarations OWNER TO akinadmin;

--
-- Name: sgk_declarations_declaration_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.sgk_declarations_declaration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sgk_declarations_declaration_id_seq OWNER TO akinadmin;

--
-- Name: sgk_declarations_declaration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.sgk_declarations_declaration_id_seq OWNED BY public.sgk_declarations.declaration_id;


--
-- Name: shift_schedules; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.shift_schedules (
    schedule_id integer NOT NULL,
    schedule_name character varying(100) NOT NULL,
    shift_type character varying(20),
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    break_duration integer DEFAULT 0,
    is_active boolean DEFAULT true,
    CONSTRAINT shift_schedules_shift_type_check CHECK (((shift_type)::text = ANY ((ARRAY['morning'::character varying, 'afternoon'::character varying, 'night'::character varying, 'rotating'::character varying])::text[])))
);


ALTER TABLE public.shift_schedules OWNER TO akinadmin;

--
-- Name: shift_schedules_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.shift_schedules_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shift_schedules_schedule_id_seq OWNER TO akinadmin;

--
-- Name: shift_schedules_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.shift_schedules_schedule_id_seq OWNED BY public.shift_schedules.schedule_id;


--
-- Name: shipping_methods; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.shipping_methods (
    method_id integer NOT NULL,
    method_name character varying(100) NOT NULL,
    carrier character varying(100),
    estimated_days integer,
    cost numeric(10,2),
    is_active boolean DEFAULT true
);


ALTER TABLE public.shipping_methods OWNER TO akinadmin;

--
-- Name: shipping_methods_method_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.shipping_methods_method_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shipping_methods_method_id_seq OWNER TO akinadmin;

--
-- Name: shipping_methods_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.shipping_methods_method_id_seq OWNED BY public.shipping_methods.method_id;


--
-- Name: sms_logs; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.sms_logs (
    sms_id integer NOT NULL,
    phone_number character varying(20) NOT NULL,
    message text,
    status character varying(20),
    sent_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cost numeric(10,4),
    CONSTRAINT sms_logs_status_check CHECK (((status)::text = ANY ((ARRAY['sent'::character varying, 'failed'::character varying])::text[])))
);


ALTER TABLE public.sms_logs OWNER TO akinadmin;

--
-- Name: sms_logs_sms_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.sms_logs_sms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sms_logs_sms_id_seq OWNER TO akinadmin;

--
-- Name: sms_logs_sms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.sms_logs_sms_id_seq OWNED BY public.sms_logs.sms_id;


--
-- Name: sms_templates; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.sms_templates (
    template_id integer NOT NULL,
    template_name character varying(100) NOT NULL,
    message text NOT NULL,
    variables jsonb,
    category character varying(50),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sms_templates OWNER TO akinadmin;

--
-- Name: sms_templates_template_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.sms_templates_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sms_templates_template_id_seq OWNER TO akinadmin;

--
-- Name: sms_templates_template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.sms_templates_template_id_seq OWNED BY public.sms_templates.template_id;


--
-- Name: stock_count_items; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.stock_count_items (
    item_id integer NOT NULL,
    count_id integer,
    part_id integer,
    system_quantity integer,
    counted_quantity integer,
    difference integer,
    notes text
);


ALTER TABLE public.stock_count_items OWNER TO akinadmin;

--
-- Name: stock_count_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.stock_count_items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_count_items_item_id_seq OWNER TO akinadmin;

--
-- Name: stock_count_items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.stock_count_items_item_id_seq OWNED BY public.stock_count_items.item_id;


--
-- Name: stock_counts; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.stock_counts (
    count_id integer NOT NULL,
    warehouse_id integer,
    count_date date NOT NULL,
    counted_by integer,
    status character varying(20) DEFAULT 'in_progress'::character varying,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT stock_counts_status_check CHECK (((status)::text = ANY ((ARRAY['in_progress'::character varying, 'completed'::character varying, 'approved'::character varying])::text[])))
);


ALTER TABLE public.stock_counts OWNER TO akinadmin;

--
-- Name: stock_counts_count_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.stock_counts_count_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_counts_count_id_seq OWNER TO akinadmin;

--
-- Name: stock_counts_count_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.stock_counts_count_id_seq OWNED BY public.stock_counts.count_id;


--
-- Name: stock_movements; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.stock_movements (
    movement_id integer NOT NULL,
    part_id integer,
    warehouse_id integer,
    movement_type character varying(20),
    quantity integer NOT NULL,
    unit_price numeric(10,2),
    reference_type character varying(50),
    reference_id integer,
    notes text,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT stock_movements_movement_type_check CHECK (((movement_type)::text = ANY ((ARRAY['in'::character varying, 'out'::character varying, 'transfer'::character varying, 'adjustment'::character varying])::text[])))
);


ALTER TABLE public.stock_movements OWNER TO akinadmin;

--
-- Name: stock_movements_movement_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.stock_movements_movement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_movements_movement_id_seq OWNER TO akinadmin;

--
-- Name: stock_movements_movement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.stock_movements_movement_id_seq OWNED BY public.stock_movements.movement_id;


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.subscriptions (
    subscription_id integer NOT NULL,
    service_name character varying(200) NOT NULL,
    provider character varying(200),
    subscription_type character varying(50),
    start_date date NOT NULL,
    end_date date,
    renewal_date date,
    cost numeric(10,2),
    billing_frequency character varying(20),
    auto_renewal boolean DEFAULT true,
    status character varying(20) DEFAULT 'active'::character varying,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT subscriptions_billing_frequency_check CHECK (((billing_frequency)::text = ANY ((ARRAY['monthly'::character varying, 'quarterly'::character varying, 'yearly'::character varying])::text[]))),
    CONSTRAINT subscriptions_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'cancelled'::character varying, 'expired'::character varying])::text[])))
);


ALTER TABLE public.subscriptions OWNER TO akinadmin;

--
-- Name: subscriptions_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.subscriptions_subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscriptions_subscription_id_seq OWNER TO akinadmin;

--
-- Name: subscriptions_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.subscriptions_subscription_id_seq OWNED BY public.subscriptions.subscription_id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.suppliers (
    supplier_id integer NOT NULL,
    supplier_name character varying(200) NOT NULL,
    contact_person character varying(100),
    phone character varying(20),
    email character varying(100),
    address text,
    tax_number character varying(50),
    payment_terms character varying(100),
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT suppliers_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.suppliers OWNER TO akinadmin;

--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.suppliers_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliers_supplier_id_seq OWNER TO akinadmin;

--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.suppliers_supplier_id_seq OWNED BY public.suppliers.supplier_id;


--
-- Name: survey_answers; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.survey_answers (
    answer_id integer NOT NULL,
    response_id integer,
    question_id integer,
    answer_value text
);


ALTER TABLE public.survey_answers OWNER TO akinadmin;

--
-- Name: survey_answers_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.survey_answers_answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.survey_answers_answer_id_seq OWNER TO akinadmin;

--
-- Name: survey_answers_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.survey_answers_answer_id_seq OWNED BY public.survey_answers.answer_id;


--
-- Name: survey_questions; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.survey_questions (
    question_id integer NOT NULL,
    survey_id integer,
    question_text text NOT NULL,
    question_type character varying(20),
    is_required boolean DEFAULT false,
    order_number integer,
    CONSTRAINT survey_questions_question_type_check CHECK (((question_type)::text = ANY ((ARRAY['rating'::character varying, 'text'::character varying, 'multiple_choice'::character varying])::text[])))
);


ALTER TABLE public.survey_questions OWNER TO akinadmin;

--
-- Name: survey_questions_question_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.survey_questions_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.survey_questions_question_id_seq OWNER TO akinadmin;

--
-- Name: survey_questions_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.survey_questions_question_id_seq OWNED BY public.survey_questions.question_id;


--
-- Name: survey_responses; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.survey_responses (
    response_id integer NOT NULL,
    survey_id integer,
    service_id integer,
    customer_id integer,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.survey_responses OWNER TO akinadmin;

--
-- Name: survey_responses_response_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.survey_responses_response_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.survey_responses_response_id_seq OWNER TO akinadmin;

--
-- Name: survey_responses_response_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.survey_responses_response_id_seq OWNED BY public.survey_responses.response_id;


--
-- Name: surveys; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.surveys (
    survey_id integer NOT NULL,
    survey_name character varying(200) NOT NULL,
    description text,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT surveys_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.surveys OWNER TO akinadmin;

--
-- Name: surveys_survey_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.surveys_survey_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.surveys_survey_id_seq OWNER TO akinadmin;

--
-- Name: surveys_survey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.surveys_survey_id_seq OWNED BY public.surveys.survey_id;


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.system_settings (
    setting_id integer NOT NULL,
    setting_key character varying(100) NOT NULL,
    setting_value text,
    setting_type character varying(20),
    description text,
    updated_by integer,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT system_settings_setting_type_check CHECK (((setting_type)::text = ANY ((ARRAY['string'::character varying, 'number'::character varying, 'boolean'::character varying, 'json'::character varying])::text[])))
);


ALTER TABLE public.system_settings OWNER TO akinadmin;

--
-- Name: system_settings_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.system_settings_setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.system_settings_setting_id_seq OWNER TO akinadmin;

--
-- Name: system_settings_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.system_settings_setting_id_seq OWNED BY public.system_settings.setting_id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.tags (
    tag_id integer NOT NULL,
    tag_name character varying(50) NOT NULL,
    tag_color character varying(7),
    tag_category character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tags OWNER TO akinadmin;

--
-- Name: tags_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.tags_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_tag_id_seq OWNER TO akinadmin;

--
-- Name: tags_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.tags_tag_id_seq OWNED BY public.tags.tag_id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.tasks (
    task_id integer NOT NULL,
    task_title character varying(200) NOT NULL,
    description text,
    assigned_to integer,
    created_by integer,
    priority character varying(20) DEFAULT 'medium'::character varying,
    due_date date,
    status character varying(20) DEFAULT 'pending'::character varying,
    related_entity_type character varying(50),
    related_entity_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    completed_at timestamp without time zone,
    CONSTRAINT tasks_priority_check CHECK (((priority)::text = ANY ((ARRAY['low'::character varying, 'medium'::character varying, 'high'::character varying])::text[]))),
    CONSTRAINT tasks_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'in_progress'::character varying, 'completed'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.tasks OWNER TO akinadmin;

--
-- Name: tasks_task_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.tasks_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tasks_task_id_seq OWNER TO akinadmin;

--
-- Name: tasks_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.tasks_task_id_seq OWNED BY public.tasks.task_id;


--
-- Name: tax_declarations; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.tax_declarations (
    declaration_id integer NOT NULL,
    declaration_type character varying(50),
    period_month integer,
    period_year integer,
    total_income numeric(15,2),
    total_expense numeric(15,2),
    tax_base numeric(15,2),
    tax_amount numeric(15,2),
    declaration_date date,
    payment_date date,
    status character varying(20) DEFAULT 'pending'::character varying,
    CONSTRAINT tax_declarations_declaration_type_check CHECK (((declaration_type)::text = ANY ((ARRAY['kdv'::character varying, 'gelir_vergisi'::character varying, 'stopaj'::character varying])::text[]))),
    CONSTRAINT tax_declarations_period_month_check CHECK (((period_month >= 1) AND (period_month <= 12))),
    CONSTRAINT tax_declarations_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'declared'::character varying, 'paid'::character varying])::text[])))
);


ALTER TABLE public.tax_declarations OWNER TO akinadmin;

--
-- Name: tax_declarations_declaration_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.tax_declarations_declaration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tax_declarations_declaration_id_seq OWNER TO akinadmin;

--
-- Name: tax_declarations_declaration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.tax_declarations_declaration_id_seq OWNED BY public.tax_declarations.declaration_id;


--
-- Name: technician_locations; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.technician_locations (
    location_id integer NOT NULL,
    technician_id integer,
    latitude numeric(10,8) NOT NULL,
    longitude numeric(11,8) NOT NULL,
    accuracy numeric(10,2),
    speed numeric(10,2),
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.technician_locations OWNER TO akinadmin;

--
-- Name: technician_locations_location_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.technician_locations_location_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.technician_locations_location_id_seq OWNER TO akinadmin;

--
-- Name: technician_locations_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.technician_locations_location_id_seq OWNED BY public.technician_locations.location_id;


--
-- Name: technician_performance; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.technician_performance (
    performance_id integer NOT NULL,
    technician_id integer,
    period_month integer,
    period_year integer,
    completed_services integer DEFAULT 0,
    average_rating numeric(3,2),
    total_revenue numeric(10,2),
    customer_complaints integer DEFAULT 0,
    on_time_percentage numeric(5,2),
    CONSTRAINT technician_performance_period_month_check CHECK (((period_month >= 1) AND (period_month <= 12)))
);


ALTER TABLE public.technician_performance OWNER TO akinadmin;

--
-- Name: technician_performance_performance_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.technician_performance_performance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.technician_performance_performance_id_seq OWNER TO akinadmin;

--
-- Name: technician_performance_performance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.technician_performance_performance_id_seq OWNED BY public.technician_performance.performance_id;


--
-- Name: technician_reviews; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.technician_reviews (
    review_id integer NOT NULL,
    technician_id integer,
    service_id integer,
    customer_id integer,
    rating integer,
    review_text text,
    is_public boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT technician_reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.technician_reviews OWNER TO akinadmin;

--
-- Name: technician_reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.technician_reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.technician_reviews_review_id_seq OWNER TO akinadmin;

--
-- Name: technician_reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.technician_reviews_review_id_seq OWNED BY public.technician_reviews.review_id;


--
-- Name: technician_skill_assignments; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.technician_skill_assignments (
    assignment_id integer NOT NULL,
    technician_id integer,
    skill_id integer,
    proficiency_level character varying(20),
    years_experience integer,
    certified boolean DEFAULT false,
    certification_date date,
    notes text,
    CONSTRAINT technician_skill_assignments_proficiency_level_check CHECK (((proficiency_level)::text = ANY ((ARRAY['beginner'::character varying, 'intermediate'::character varying, 'advanced'::character varying, 'expert'::character varying])::text[])))
);


ALTER TABLE public.technician_skill_assignments OWNER TO akinadmin;

--
-- Name: technician_skill_assignments_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.technician_skill_assignments_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.technician_skill_assignments_assignment_id_seq OWNER TO akinadmin;

--
-- Name: technician_skill_assignments_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.technician_skill_assignments_assignment_id_seq OWNED BY public.technician_skill_assignments.assignment_id;


--
-- Name: technician_skills; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.technician_skills (
    skill_id integer NOT NULL,
    skill_name character varying(100) NOT NULL,
    skill_category character varying(50),
    description text
);


ALTER TABLE public.technician_skills OWNER TO akinadmin;

--
-- Name: technician_skills_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.technician_skills_skill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.technician_skills_skill_id_seq OWNER TO akinadmin;

--
-- Name: technician_skills_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.technician_skills_skill_id_seq OWNED BY public.technician_skills.skill_id;


--
-- Name: technician_trainings; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.technician_trainings (
    training_id integer NOT NULL,
    technician_id integer,
    program_id integer,
    training_date date,
    completion_date date,
    score integer,
    certificate_number character varying(100),
    expiry_date date,
    status character varying(20) DEFAULT 'completed'::character varying,
    CONSTRAINT technician_trainings_score_check CHECK (((score >= 0) AND (score <= 100))),
    CONSTRAINT technician_trainings_status_check CHECK (((status)::text = ANY ((ARRAY['scheduled'::character varying, 'in_progress'::character varying, 'completed'::character varying, 'failed'::character varying])::text[])))
);


ALTER TABLE public.technician_trainings OWNER TO akinadmin;

--
-- Name: technician_trainings_training_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.technician_trainings_training_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.technician_trainings_training_id_seq OWNER TO akinadmin;

--
-- Name: technician_trainings_training_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.technician_trainings_training_id_seq OWNED BY public.technician_trainings.training_id;


--
-- Name: technicians; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.technicians (
    technician_id integer NOT NULL,
    user_id integer,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    phone character varying(20),
    email character varying(100),
    specialization character varying(100),
    experience_years integer,
    hourly_rate numeric(10,2),
    vehicle_id integer,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    employee_number character varying(50),
    national_id character varying(50),
    birth_date date,
    hire_date date,
    termination_date date,
    emergency_contact_name character varying(100),
    emergency_contact_phone character varying(20),
    address text,
    city character varying(100),
    license_number character varying(100),
    license_expiry date,
    uniform_size character varying(20),
    tools_assigned text,
    CONSTRAINT technicians_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'on_leave'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.technicians OWNER TO akinadmin;

--
-- Name: technicians_technician_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.technicians_technician_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.technicians_technician_id_seq OWNER TO akinadmin;

--
-- Name: technicians_technician_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.technicians_technician_id_seq OWNED BY public.technicians.technician_id;


--
-- Name: territories; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.territories (
    territory_id integer NOT NULL,
    territory_name character varying(100) NOT NULL,
    territory_code character varying(20),
    parent_territory_id integer,
    manager_id integer,
    cities jsonb,
    districts jsonb,
    postal_codes jsonb,
    description text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.territories OWNER TO akinadmin;

--
-- Name: territories_territory_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.territories_territory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.territories_territory_id_seq OWNER TO akinadmin;

--
-- Name: territories_territory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.territories_territory_id_seq OWNED BY public.territories.territory_id;


--
-- Name: time_off_requests; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.time_off_requests (
    request_id integer NOT NULL,
    technician_id integer,
    start_date date NOT NULL,
    end_date date NOT NULL,
    reason text,
    status character varying(20) DEFAULT 'pending'::character varying,
    approved_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT time_off_requests_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[])))
);


ALTER TABLE public.time_off_requests OWNER TO akinadmin;

--
-- Name: time_off_requests_request_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.time_off_requests_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.time_off_requests_request_id_seq OWNER TO akinadmin;

--
-- Name: time_off_requests_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.time_off_requests_request_id_seq OWNED BY public.time_off_requests.request_id;


--
-- Name: training_programs; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.training_programs (
    program_id integer NOT NULL,
    program_name character varying(200) NOT NULL,
    description text,
    duration_hours integer,
    cost numeric(10,2),
    status character varying(20) DEFAULT 'active'::character varying,
    CONSTRAINT training_programs_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.training_programs OWNER TO akinadmin;

--
-- Name: training_programs_program_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.training_programs_program_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.training_programs_program_id_seq OWNER TO akinadmin;

--
-- Name: training_programs_program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.training_programs_program_id_seq OWNED BY public.training_programs.program_id;


--
-- Name: transfers; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.transfers (
    transfer_id integer NOT NULL,
    from_account_id integer,
    to_account_id integer,
    amount numeric(10,2) NOT NULL,
    transfer_date date NOT NULL,
    description text,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.transfers OWNER TO akinadmin;

--
-- Name: transfers_transfer_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.transfers_transfer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transfers_transfer_id_seq OWNER TO akinadmin;

--
-- Name: transfers_transfer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.transfers_transfer_id_seq OWNED BY public.transfers.transfer_id;


--
-- Name: two_factor_auth; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.two_factor_auth (
    tfa_id integer NOT NULL,
    user_id integer,
    secret_key character varying(255) NOT NULL,
    is_enabled boolean DEFAULT false,
    backup_codes jsonb,
    enabled_at timestamp without time zone,
    last_used_at timestamp without time zone
);


ALTER TABLE public.two_factor_auth OWNER TO akinadmin;

--
-- Name: two_factor_auth_tfa_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.two_factor_auth_tfa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.two_factor_auth_tfa_id_seq OWNER TO akinadmin;

--
-- Name: two_factor_auth_tfa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.two_factor_auth_tfa_id_seq OWNED BY public.two_factor_auth.tfa_id;


--
-- Name: user_dashboard_widgets; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.user_dashboard_widgets (
    user_widget_id integer NOT NULL,
    user_id integer,
    widget_id integer,
    position_x integer,
    position_y integer,
    width integer,
    height integer,
    custom_config jsonb
);


ALTER TABLE public.user_dashboard_widgets OWNER TO akinadmin;

--
-- Name: user_dashboard_widgets_user_widget_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.user_dashboard_widgets_user_widget_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_dashboard_widgets_user_widget_id_seq OWNER TO akinadmin;

--
-- Name: user_dashboard_widgets_user_widget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.user_dashboard_widgets_user_widget_id_seq OWNED BY public.user_dashboard_widgets.user_widget_id;


--
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.user_preferences (
    preference_id integer NOT NULL,
    user_id integer,
    theme character varying(20) DEFAULT 'light'::character varying,
    language character varying(10) DEFAULT 'tr'::character varying,
    timezone character varying(50) DEFAULT 'Europe/Istanbul'::character varying,
    date_format character varying(20) DEFAULT 'DD/MM/YYYY'::character varying,
    time_format character varying(20) DEFAULT '24h'::character varying,
    currency character varying(3) DEFAULT 'TRY'::character varying,
    items_per_page integer DEFAULT 25,
    preferences jsonb,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_preferences OWNER TO akinadmin;

--
-- Name: user_preferences_preference_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.user_preferences_preference_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_preferences_preference_id_seq OWNER TO akinadmin;

--
-- Name: user_preferences_preference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.user_preferences_preference_id_seq OWNED BY public.user_preferences.preference_id;


--
-- Name: user_sessions; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.user_sessions (
    session_id integer NOT NULL,
    user_id integer,
    session_token character varying(255) NOT NULL,
    ip_address character varying(45),
    user_agent text,
    device_type character varying(50),
    device_name character varying(100),
    login_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_activity_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    logout_at timestamp without time zone,
    is_active boolean DEFAULT true
);


ALTER TABLE public.user_sessions OWNER TO akinadmin;

--
-- Name: user_sessions_session_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.user_sessions_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_sessions_session_id_seq OWNER TO akinadmin;

--
-- Name: user_sessions_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.user_sessions_session_id_seq OWNED BY public.user_sessions.session_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role_id integer,
    status character varying(20) DEFAULT 'active'::character varying,
    last_login timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO akinadmin;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO akinadmin;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: vehicle_expenses; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.vehicle_expenses (
    expense_id integer NOT NULL,
    vehicle_id integer,
    expense_type character varying(50),
    expense_date date NOT NULL,
    amount numeric(10,2) NOT NULL,
    odometer_reading integer,
    description text,
    receipt_path character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT vehicle_expenses_expense_type_check CHECK (((expense_type)::text = ANY ((ARRAY['fuel'::character varying, 'maintenance'::character varying, 'insurance'::character varying, 'tax'::character varying])::text[])))
);


ALTER TABLE public.vehicle_expenses OWNER TO akinadmin;

--
-- Name: vehicle_expenses_expense_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.vehicle_expenses_expense_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vehicle_expenses_expense_id_seq OWNER TO akinadmin;

--
-- Name: vehicle_expenses_expense_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.vehicle_expenses_expense_id_seq OWNED BY public.vehicle_expenses.expense_id;


--
-- Name: vehicle_stock; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.vehicle_stock (
    vehicle_stock_id integer NOT NULL,
    technician_id integer,
    part_id integer,
    quantity integer DEFAULT 0,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vehicle_stock OWNER TO akinadmin;

--
-- Name: vehicle_stock_vehicle_stock_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.vehicle_stock_vehicle_stock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vehicle_stock_vehicle_stock_id_seq OWNER TO akinadmin;

--
-- Name: vehicle_stock_vehicle_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.vehicle_stock_vehicle_stock_id_seq OWNED BY public.vehicle_stock.vehicle_stock_id;


--
-- Name: vehicles; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.vehicles (
    vehicle_id integer NOT NULL,
    plate_number character varying(20) NOT NULL,
    brand character varying(50),
    model character varying(50),
    year integer,
    assigned_technician_id integer,
    insurance_company character varying(100),
    insurance_expiry date,
    inspection_expiry date,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT vehicles_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'maintenance'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE public.vehicles OWNER TO akinadmin;

--
-- Name: vehicles_vehicle_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.vehicles_vehicle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vehicles_vehicle_id_seq OWNER TO akinadmin;

--
-- Name: vehicles_vehicle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.vehicles_vehicle_id_seq OWNED BY public.vehicles.vehicle_id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.versions (
    version_id integer NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id integer NOT NULL,
    version_number integer NOT NULL,
    data jsonb,
    change_summary text,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.versions OWNER TO akinadmin;

--
-- Name: versions_version_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.versions_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.versions_version_id_seq OWNER TO akinadmin;

--
-- Name: versions_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.versions_version_id_seq OWNED BY public.versions.version_id;


--
-- Name: warehouses; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.warehouses (
    warehouse_id integer NOT NULL,
    warehouse_name character varying(100) NOT NULL,
    warehouse_type character varying(20),
    address text,
    responsible_person character varying(100),
    status character varying(20) DEFAULT 'active'::character varying,
    CONSTRAINT warehouses_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[]))),
    CONSTRAINT warehouses_warehouse_type_check CHECK (((warehouse_type)::text = ANY ((ARRAY['main'::character varying, 'vehicle'::character varying])::text[])))
);


ALTER TABLE public.warehouses OWNER TO akinadmin;

--
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.warehouses_warehouse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.warehouses_warehouse_id_seq OWNER TO akinadmin;

--
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.warehouses_warehouse_id_seq OWNED BY public.warehouses.warehouse_id;


--
-- Name: warranties; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.warranties (
    warranty_id integer NOT NULL,
    warranty_type character varying(20),
    entity_type character varying(50),
    entity_id integer,
    start_date date NOT NULL,
    end_date date NOT NULL,
    warranty_terms text,
    provider character varying(200),
    status character varying(20) DEFAULT 'active'::character varying,
    CONSTRAINT warranties_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'expired'::character varying, 'claimed'::character varying])::text[]))),
    CONSTRAINT warranties_warranty_type_check CHECK (((warranty_type)::text = ANY ((ARRAY['device'::character varying, 'part'::character varying, 'service'::character varying])::text[])))
);


ALTER TABLE public.warranties OWNER TO akinadmin;

--
-- Name: warranties_warranty_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.warranties_warranty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.warranties_warranty_id_seq OWNER TO akinadmin;

--
-- Name: warranties_warranty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.warranties_warranty_id_seq OWNED BY public.warranties.warranty_id;


--
-- Name: warranty_claims; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.warranty_claims (
    claim_id integer NOT NULL,
    warranty_id integer,
    claim_date date NOT NULL,
    issue_description text,
    resolution text,
    claim_status character varying(20) DEFAULT 'pending'::character varying,
    resolved_date date,
    CONSTRAINT warranty_claims_claim_status_check CHECK (((claim_status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying, 'completed'::character varying])::text[])))
);


ALTER TABLE public.warranty_claims OWNER TO akinadmin;

--
-- Name: warranty_claims_claim_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.warranty_claims_claim_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.warranty_claims_claim_id_seq OWNER TO akinadmin;

--
-- Name: warranty_claims_claim_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.warranty_claims_claim_id_seq OWNED BY public.warranty_claims.claim_id;


--
-- Name: webhook_logs; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.webhook_logs (
    log_id integer NOT NULL,
    webhook_id integer,
    event_type character varying(100),
    payload jsonb,
    response_status integer,
    response_body text,
    attempt_number integer,
    triggered_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.webhook_logs OWNER TO akinadmin;

--
-- Name: webhook_logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.webhook_logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.webhook_logs_log_id_seq OWNER TO akinadmin;

--
-- Name: webhook_logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.webhook_logs_log_id_seq OWNED BY public.webhook_logs.log_id;


--
-- Name: webhooks; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.webhooks (
    webhook_id integer NOT NULL,
    webhook_name character varying(100) NOT NULL,
    url character varying(500) NOT NULL,
    event_type character varying(100),
    secret_key character varying(255),
    is_active boolean DEFAULT true,
    retry_count integer DEFAULT 3,
    timeout_seconds integer DEFAULT 30,
    last_triggered_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.webhooks OWNER TO akinadmin;

--
-- Name: webhooks_webhook_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.webhooks_webhook_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.webhooks_webhook_id_seq OWNER TO akinadmin;

--
-- Name: webhooks_webhook_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.webhooks_webhook_id_seq OWNED BY public.webhooks.webhook_id;


--
-- Name: work_orders; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.work_orders (
    work_order_id integer NOT NULL,
    work_order_number character varying(50) NOT NULL,
    service_id integer,
    quotation_id integer,
    assigned_technician_id integer,
    priority character varying(20) DEFAULT 'medium'::character varying,
    status character varying(20) DEFAULT 'pending'::character varying,
    scheduled_date date,
    completed_date date,
    instructions text,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT work_orders_priority_check CHECK (((priority)::text = ANY ((ARRAY['low'::character varying, 'medium'::character varying, 'high'::character varying, 'urgent'::character varying])::text[]))),
    CONSTRAINT work_orders_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'assigned'::character varying, 'in_progress'::character varying, 'completed'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.work_orders OWNER TO akinadmin;

--
-- Name: work_orders_work_order_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.work_orders_work_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.work_orders_work_order_id_seq OWNER TO akinadmin;

--
-- Name: work_orders_work_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.work_orders_work_order_id_seq OWNED BY public.work_orders.work_order_id;


--
-- Name: workflow_steps; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.workflow_steps (
    step_id integer NOT NULL,
    workflow_id integer,
    step_order integer NOT NULL,
    step_name character varying(100),
    step_type character varying(50),
    step_config jsonb,
    is_required boolean DEFAULT true,
    CONSTRAINT workflow_steps_step_type_check CHECK (((step_type)::text = ANY ((ARRAY['approval'::character varying, 'notification'::character varying, 'action'::character varying, 'condition'::character varying])::text[])))
);


ALTER TABLE public.workflow_steps OWNER TO akinadmin;

--
-- Name: workflow_steps_step_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.workflow_steps_step_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workflow_steps_step_id_seq OWNER TO akinadmin;

--
-- Name: workflow_steps_step_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.workflow_steps_step_id_seq OWNED BY public.workflow_steps.step_id;


--
-- Name: workflows; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.workflows (
    workflow_id integer NOT NULL,
    workflow_name character varying(100) NOT NULL,
    workflow_type character varying(50),
    description text,
    trigger_event character varying(100),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.workflows OWNER TO akinadmin;

--
-- Name: workflows_workflow_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.workflows_workflow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workflows_workflow_id_seq OWNER TO akinadmin;

--
-- Name: workflows_workflow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.workflows_workflow_id_seq OWNED BY public.workflows.workflow_id;


--
-- Name: working_hours; Type: TABLE; Schema: public; Owner: akinadmin
--

CREATE TABLE public.working_hours (
    schedule_id integer NOT NULL,
    technician_id integer,
    day_of_week integer,
    start_time time without time zone,
    end_time time without time zone,
    is_available boolean DEFAULT true,
    CONSTRAINT working_hours_day_of_week_check CHECK (((day_of_week >= 0) AND (day_of_week <= 6)))
);


ALTER TABLE public.working_hours OWNER TO akinadmin;

--
-- Name: working_hours_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: akinadmin
--

CREATE SEQUENCE public.working_hours_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.working_hours_schedule_id_seq OWNER TO akinadmin;

--
-- Name: working_hours_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: akinadmin
--

ALTER SEQUENCE public.working_hours_schedule_id_seq OWNED BY public.working_hours.schedule_id;


--
-- Name: account_transactions transaction_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.account_transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.account_transactions_transaction_id_seq'::regclass);


--
-- Name: accounts account_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.accounts ALTER COLUMN account_id SET DEFAULT nextval('public.accounts_account_id_seq'::regclass);


--
-- Name: activity_logs log_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.activity_logs ALTER COLUMN log_id SET DEFAULT nextval('public.activity_logs_log_id_seq'::regclass);


--
-- Name: advance_payments advance_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.advance_payments ALTER COLUMN advance_id SET DEFAULT nextval('public.advance_payments_advance_id_seq'::regclass);


--
-- Name: api_keys key_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.api_keys ALTER COLUMN key_id SET DEFAULT nextval('public.api_keys_key_id_seq'::regclass);


--
-- Name: api_rate_limits limit_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.api_rate_limits ALTER COLUMN limit_id SET DEFAULT nextval('public.api_rate_limits_limit_id_seq'::regclass);


--
-- Name: appointments appointment_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.appointments ALTER COLUMN appointment_id SET DEFAULT nextval('public.appointments_appointment_id_seq'::regclass);


--
-- Name: approvals approval_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.approvals ALTER COLUMN approval_id SET DEFAULT nextval('public.approvals_approval_id_seq'::regclass);


--
-- Name: assets asset_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.assets ALTER COLUMN asset_id SET DEFAULT nextval('public.assets_asset_id_seq'::regclass);


--
-- Name: attachments attachment_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.attachments ALTER COLUMN attachment_id SET DEFAULT nextval('public.attachments_attachment_id_seq'::regclass);


--
-- Name: attendance attendance_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.attendance ALTER COLUMN attendance_id SET DEFAULT nextval('public.attendance_attendance_id_seq'::regclass);


--
-- Name: audit_trail audit_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.audit_trail ALTER COLUMN audit_id SET DEFAULT nextval('public.audit_trail_audit_id_seq'::regclass);


--
-- Name: automation_rules rule_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.automation_rules ALTER COLUMN rule_id SET DEFAULT nextval('public.automation_rules_rule_id_seq'::regclass);


--
-- Name: backup_logs backup_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.backup_logs ALTER COLUMN backup_id SET DEFAULT nextval('public.backup_logs_backup_id_seq'::regclass);


--
-- Name: bank_reconciliation reconciliation_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.bank_reconciliation ALTER COLUMN reconciliation_id SET DEFAULT nextval('public.bank_reconciliation_reconciliation_id_seq'::regclass);


--
-- Name: bank_reconciliation_items item_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.bank_reconciliation_items ALTER COLUMN item_id SET DEFAULT nextval('public.bank_reconciliation_items_item_id_seq'::regclass);


--
-- Name: bookmarks bookmark_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.bookmarks ALTER COLUMN bookmark_id SET DEFAULT nextval('public.bookmarks_bookmark_id_seq'::regclass);


--
-- Name: budgets budget_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.budgets ALTER COLUMN budget_id SET DEFAULT nextval('public.budgets_budget_id_seq'::regclass);


--
-- Name: call_recordings recording_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.call_recordings ALTER COLUMN recording_id SET DEFAULT nextval('public.call_recordings_recording_id_seq'::regclass);


--
-- Name: calls call_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.calls ALTER COLUMN call_id SET DEFAULT nextval('public.calls_call_id_seq'::regclass);


--
-- Name: campaigns campaign_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.campaigns ALTER COLUMN campaign_id SET DEFAULT nextval('public.campaigns_campaign_id_seq'::regclass);


--
-- Name: certifications certification_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.certifications ALTER COLUMN certification_id SET DEFAULT nextval('public.certifications_certification_id_seq'::regclass);


--
-- Name: checks check_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.checks ALTER COLUMN check_id SET DEFAULT nextval('public.checks_check_id_seq'::regclass);


--
-- Name: comments comment_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.comments ALTER COLUMN comment_id SET DEFAULT nextval('public.comments_comment_id_seq'::regclass);


--
-- Name: commissions commission_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.commissions ALTER COLUMN commission_id SET DEFAULT nextval('public.commissions_commission_id_seq'::regclass);


--
-- Name: communication_logs log_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.communication_logs ALTER COLUMN log_id SET DEFAULT nextval('public.communication_logs_log_id_seq'::regclass);


--
-- Name: complaints complaint_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.complaints ALTER COLUMN complaint_id SET DEFAULT nextval('public.complaints_complaint_id_seq'::regclass);


--
-- Name: contract_services contract_service_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.contract_services ALTER COLUMN contract_service_id SET DEFAULT nextval('public.contract_services_contract_service_id_seq'::regclass);


--
-- Name: contracts contract_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.contracts ALTER COLUMN contract_id SET DEFAULT nextval('public.contracts_contract_id_seq'::regclass);


--
-- Name: coupon_usage usage_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.coupon_usage ALTER COLUMN usage_id SET DEFAULT nextval('public.coupon_usage_usage_id_seq'::regclass);


--
-- Name: coupons coupon_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.coupons ALTER COLUMN coupon_id SET DEFAULT nextval('public.coupons_coupon_id_seq'::regclass);


--
-- Name: credit_limits limit_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_limits ALTER COLUMN limit_id SET DEFAULT nextval('public.credit_limits_limit_id_seq'::regclass);


--
-- Name: credit_note_items item_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_note_items ALTER COLUMN item_id SET DEFAULT nextval('public.credit_note_items_item_id_seq'::regclass);


--
-- Name: credit_notes credit_note_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_notes ALTER COLUMN credit_note_id SET DEFAULT nextval('public.credit_notes_credit_note_id_seq'::regclass);


--
-- Name: current_account_transactions transaction_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.current_account_transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.current_account_transactions_transaction_id_seq'::regclass);


--
-- Name: current_accounts account_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.current_accounts ALTER COLUMN account_id SET DEFAULT nextval('public.current_accounts_account_id_seq'::regclass);


--
-- Name: customer_addresses address_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_addresses ALTER COLUMN address_id SET DEFAULT nextval('public.customer_addresses_address_id_seq'::regclass);


--
-- Name: customer_contacts contact_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_contacts ALTER COLUMN contact_id SET DEFAULT nextval('public.customer_contacts_contact_id_seq'::regclass);


--
-- Name: customer_notes note_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_notes ALTER COLUMN note_id SET DEFAULT nextval('public.customer_notes_note_id_seq'::regclass);


--
-- Name: customer_preferences preference_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_preferences ALTER COLUMN preference_id SET DEFAULT nextval('public.customer_preferences_preference_id_seq'::regclass);


--
-- Name: customers customer_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customers ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customer_id_seq'::regclass);


--
-- Name: dashboard_widgets widget_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.dashboard_widgets ALTER COLUMN widget_id SET DEFAULT nextval('public.dashboard_widgets_widget_id_seq'::regclass);


--
-- Name: data_exports export_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.data_exports ALTER COLUMN export_id SET DEFAULT nextval('public.data_exports_export_id_seq'::regclass);


--
-- Name: debit_notes debit_note_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.debit_notes ALTER COLUMN debit_note_id SET DEFAULT nextval('public.debit_notes_debit_note_id_seq'::regclass);


--
-- Name: depreciation depreciation_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.depreciation ALTER COLUMN depreciation_id SET DEFAULT nextval('public.depreciation_depreciation_id_seq'::regclass);


--
-- Name: device_documents document_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.device_documents ALTER COLUMN document_id SET DEFAULT nextval('public.device_documents_document_id_seq'::regclass);


--
-- Name: device_history history_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.device_history ALTER COLUMN history_id SET DEFAULT nextval('public.device_history_history_id_seq'::regclass);


--
-- Name: device_parts device_part_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.device_parts ALTER COLUMN device_part_id SET DEFAULT nextval('public.device_parts_device_part_id_seq'::regclass);


--
-- Name: devices device_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.devices ALTER COLUMN device_id SET DEFAULT nextval('public.devices_device_id_seq'::regclass);


--
-- Name: discount_codes code_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.discount_codes ALTER COLUMN code_id SET DEFAULT nextval('public.discount_codes_code_id_seq'::regclass);


--
-- Name: document_photos photo_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.document_photos ALTER COLUMN photo_id SET DEFAULT nextval('public.document_photos_photo_id_seq'::regclass);


--
-- Name: documents document_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.documents ALTER COLUMN document_id SET DEFAULT nextval('public.documents_document_id_seq'::regclass);


--
-- Name: email_logs email_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.email_logs ALTER COLUMN email_id SET DEFAULT nextval('public.email_logs_email_id_seq'::regclass);


--
-- Name: email_templates template_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.email_templates ALTER COLUMN template_id SET DEFAULT nextval('public.email_templates_template_id_seq'::regclass);


--
-- Name: emergency_contacts contact_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.emergency_contacts ALTER COLUMN contact_id SET DEFAULT nextval('public.emergency_contacts_contact_id_seq'::regclass);


--
-- Name: employee_documents document_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.employee_documents ALTER COLUMN document_id SET DEFAULT nextval('public.employee_documents_document_id_seq'::regclass);


--
-- Name: employee_shifts assignment_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.employee_shifts ALTER COLUMN assignment_id SET DEFAULT nextval('public.employee_shifts_assignment_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);


--
-- Name: entity_tags entity_tag_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.entity_tags ALTER COLUMN entity_tag_id SET DEFAULT nextval('public.entity_tags_entity_tag_id_seq'::regclass);


--
-- Name: exchange_rates rate_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.exchange_rates ALTER COLUMN rate_id SET DEFAULT nextval('public.exchange_rates_rate_id_seq'::regclass);


--
-- Name: expense_categories category_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.expense_categories ALTER COLUMN category_id SET DEFAULT nextval('public.expense_categories_category_id_seq'::regclass);


--
-- Name: expenses expense_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.expenses ALTER COLUMN expense_id SET DEFAULT nextval('public.expenses_expense_id_seq'::regclass);


--
-- Name: failed_jobs failed_job_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN failed_job_id SET DEFAULT nextval('public.failed_jobs_failed_job_id_seq'::regclass);


--
-- Name: fault_codes code_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.fault_codes ALTER COLUMN code_id SET DEFAULT nextval('public.fault_codes_code_id_seq'::regclass);


--
-- Name: files file_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.files ALTER COLUMN file_id SET DEFAULT nextval('public.files_file_id_seq'::regclass);


--
-- Name: holidays holiday_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.holidays ALTER COLUMN holiday_id SET DEFAULT nextval('public.holidays_holiday_id_seq'::regclass);


--
-- Name: installment_plans plan_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.installment_plans ALTER COLUMN plan_id SET DEFAULT nextval('public.installment_plans_plan_id_seq'::regclass);


--
-- Name: installments installment_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.installments ALTER COLUMN installment_id SET DEFAULT nextval('public.installments_installment_id_seq'::regclass);


--
-- Name: insurance_policies policy_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.insurance_policies ALTER COLUMN policy_id SET DEFAULT nextval('public.insurance_policies_policy_id_seq'::regclass);


--
-- Name: integration_logs log_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.integration_logs ALTER COLUMN log_id SET DEFAULT nextval('public.integration_logs_log_id_seq'::regclass);


--
-- Name: internal_messages message_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.internal_messages ALTER COLUMN message_id SET DEFAULT nextval('public.internal_messages_message_id_seq'::regclass);


--
-- Name: inventory_adjustment_items item_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.inventory_adjustment_items ALTER COLUMN item_id SET DEFAULT nextval('public.inventory_adjustment_items_item_id_seq'::regclass);


--
-- Name: inventory_adjustments adjustment_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.inventory_adjustments ALTER COLUMN adjustment_id SET DEFAULT nextval('public.inventory_adjustments_adjustment_id_seq'::regclass);


--
-- Name: invoice_items item_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.invoice_items ALTER COLUMN item_id SET DEFAULT nextval('public.invoice_items_item_id_seq'::regclass);


--
-- Name: invoices invoice_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.invoices ALTER COLUMN invoice_id SET DEFAULT nextval('public.invoices_invoice_id_seq'::regclass);


--
-- Name: ip_whitelist whitelist_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.ip_whitelist ALTER COLUMN whitelist_id SET DEFAULT nextval('public.ip_whitelist_whitelist_id_seq'::regclass);


--
-- Name: kpi_metrics metric_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.kpi_metrics ALTER COLUMN metric_id SET DEFAULT nextval('public.kpi_metrics_metric_id_seq'::regclass);


--
-- Name: leaves leave_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.leaves ALTER COLUMN leave_id SET DEFAULT nextval('public.leaves_leave_id_seq'::regclass);


--
-- Name: licenses license_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.licenses ALTER COLUMN license_id SET DEFAULT nextval('public.licenses_license_id_seq'::regclass);


--
-- Name: login_attempts attempt_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.login_attempts ALTER COLUMN attempt_id SET DEFAULT nextval('public.login_attempts_attempt_id_seq'::regclass);


--
-- Name: maintenance_schedules schedule_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.maintenance_schedules ALTER COLUMN schedule_id SET DEFAULT nextval('public.maintenance_schedules_schedule_id_seq'::regclass);


--
-- Name: marketing_messages message_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.marketing_messages ALTER COLUMN message_id SET DEFAULT nextval('public.marketing_messages_message_id_seq'::regclass);


--
-- Name: migrations migration_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.migrations ALTER COLUMN migration_id SET DEFAULT nextval('public.migrations_migration_id_seq'::regclass);


--
-- Name: notification_preferences preference_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.notification_preferences ALTER COLUMN preference_id SET DEFAULT nextval('public.notification_preferences_preference_id_seq'::regclass);


--
-- Name: notification_templates template_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.notification_templates ALTER COLUMN template_id SET DEFAULT nextval('public.notification_templates_template_id_seq'::regclass);


--
-- Name: notifications notification_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notifications_notification_id_seq'::regclass);


--
-- Name: overtime overtime_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.overtime ALTER COLUMN overtime_id SET DEFAULT nextval('public.overtime_overtime_id_seq'::regclass);


--
-- Name: part_photos photo_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_photos ALTER COLUMN photo_id SET DEFAULT nextval('public.part_photos_photo_id_seq'::regclass);


--
-- Name: part_returns return_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_returns ALTER COLUMN return_id SET DEFAULT nextval('public.part_returns_return_id_seq'::regclass);


--
-- Name: part_suppliers part_supplier_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_suppliers ALTER COLUMN part_supplier_id SET DEFAULT nextval('public.part_suppliers_part_supplier_id_seq'::regclass);


--
-- Name: partner_current_accounts account_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.partner_current_accounts ALTER COLUMN account_id SET DEFAULT nextval('public.partner_current_accounts_account_id_seq'::regclass);


--
-- Name: partner_transactions transaction_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.partner_transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.partner_transactions_transaction_id_seq'::regclass);


--
-- Name: partners partner_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.partners ALTER COLUMN partner_id SET DEFAULT nextval('public.partners_partner_id_seq'::regclass);


--
-- Name: parts part_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.parts ALTER COLUMN part_id SET DEFAULT nextval('public.parts_part_id_seq'::regclass);


--
-- Name: password_resets reset_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.password_resets ALTER COLUMN reset_id SET DEFAULT nextval('public.password_resets_reset_id_seq'::regclass);


--
-- Name: payment_plan_installments installment_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payment_plan_installments ALTER COLUMN installment_id SET DEFAULT nextval('public.payment_plan_installments_installment_id_seq'::regclass);


--
-- Name: payment_plans plan_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payment_plans ALTER COLUMN plan_id SET DEFAULT nextval('public.payment_plans_plan_id_seq'::regclass);


--
-- Name: payment_terms term_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payment_terms ALTER COLUMN term_id SET DEFAULT nextval('public.payment_terms_term_id_seq'::regclass);


--
-- Name: payments_received payment_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payments_received ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_received_payment_id_seq'::regclass);


--
-- Name: permissions permission_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.permissions ALTER COLUMN permission_id SET DEFAULT nextval('public.permissions_permission_id_seq'::regclass);


--
-- Name: petty_cash transaction_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.petty_cash ALTER COLUMN transaction_id SET DEFAULT nextval('public.petty_cash_transaction_id_seq'::regclass);


--
-- Name: price_history history_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.price_history ALTER COLUMN history_id SET DEFAULT nextval('public.price_history_history_id_seq'::regclass);


--
-- Name: price_list_items item_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.price_list_items ALTER COLUMN item_id SET DEFAULT nextval('public.price_list_items_item_id_seq'::regclass);


--
-- Name: price_lists price_list_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.price_lists ALTER COLUMN price_list_id SET DEFAULT nextval('public.price_lists_price_list_id_seq'::regclass);


--
-- Name: promissory_notes note_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.promissory_notes ALTER COLUMN note_id SET DEFAULT nextval('public.promissory_notes_note_id_seq'::regclass);


--
-- Name: purchase_order_items item_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.purchase_order_items ALTER COLUMN item_id SET DEFAULT nextval('public.purchase_order_items_item_id_seq'::regclass);


--
-- Name: purchase_orders order_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.purchase_orders ALTER COLUMN order_id SET DEFAULT nextval('public.purchase_orders_order_id_seq'::regclass);


--
-- Name: queue_jobs job_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.queue_jobs ALTER COLUMN job_id SET DEFAULT nextval('public.queue_jobs_job_id_seq'::regclass);


--
-- Name: quotation_items item_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.quotation_items ALTER COLUMN item_id SET DEFAULT nextval('public.quotation_items_item_id_seq'::regclass);


--
-- Name: quotations quotation_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.quotations ALTER COLUMN quotation_id SET DEFAULT nextval('public.quotations_quotation_id_seq'::regclass);


--
-- Name: recurring_invoices recurring_invoice_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.recurring_invoices ALTER COLUMN recurring_invoice_id SET DEFAULT nextval('public.recurring_invoices_recurring_invoice_id_seq'::regclass);


--
-- Name: referrals referral_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.referrals ALTER COLUMN referral_id SET DEFAULT nextval('public.referrals_referral_id_seq'::regclass);


--
-- Name: reminders reminder_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.reminders ALTER COLUMN reminder_id SET DEFAULT nextval('public.reminders_reminder_id_seq'::regclass);


--
-- Name: report_schedules schedule_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.report_schedules ALTER COLUMN schedule_id SET DEFAULT nextval('public.report_schedules_schedule_id_seq'::regclass);


--
-- Name: return_request_items item_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.return_request_items ALTER COLUMN item_id SET DEFAULT nextval('public.return_request_items_item_id_seq'::regclass);


--
-- Name: return_requests return_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.return_requests ALTER COLUMN return_id SET DEFAULT nextval('public.return_requests_return_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: route_stops stop_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.route_stops ALTER COLUMN stop_id SET DEFAULT nextval('public.route_stops_stop_id_seq'::regclass);


--
-- Name: routes route_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.routes ALTER COLUMN route_id SET DEFAULT nextval('public.routes_route_id_seq'::regclass);


--
-- Name: salaries salary_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.salaries ALTER COLUMN salary_id SET DEFAULT nextval('public.salaries_salary_id_seq'::regclass);


--
-- Name: saved_filters filter_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.saved_filters ALTER COLUMN filter_id SET DEFAULT nextval('public.saved_filters_filter_id_seq'::regclass);


--
-- Name: scheduled_jobs job_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.scheduled_jobs ALTER COLUMN job_id SET DEFAULT nextval('public.scheduled_jobs_job_id_seq'::regclass);


--
-- Name: scheduled_maintenance_history history_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.scheduled_maintenance_history ALTER COLUMN history_id SET DEFAULT nextval('public.scheduled_maintenance_history_history_id_seq'::regclass);


--
-- Name: service_area_pricing pricing_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_area_pricing ALTER COLUMN pricing_id SET DEFAULT nextval('public.service_area_pricing_pricing_id_seq'::regclass);


--
-- Name: service_areas area_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_areas ALTER COLUMN area_id SET DEFAULT nextval('public.service_areas_area_id_seq'::regclass);


--
-- Name: service_checklist_items item_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklist_items ALTER COLUMN item_id SET DEFAULT nextval('public.service_checklist_items_item_id_seq'::regclass);


--
-- Name: service_checklist_responses response_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklist_responses ALTER COLUMN response_id SET DEFAULT nextval('public.service_checklist_responses_response_id_seq'::regclass);


--
-- Name: service_checklist_templates template_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklist_templates ALTER COLUMN template_id SET DEFAULT nextval('public.service_checklist_templates_template_id_seq'::regclass);


--
-- Name: service_checklists checklist_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklists ALTER COLUMN checklist_id SET DEFAULT nextval('public.service_checklists_checklist_id_seq'::regclass);


--
-- Name: service_parts service_part_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_parts ALTER COLUMN service_part_id SET DEFAULT nextval('public.service_parts_service_part_id_seq'::regclass);


--
-- Name: service_photos photo_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_photos ALTER COLUMN photo_id SET DEFAULT nextval('public.service_photos_photo_id_seq'::regclass);


--
-- Name: service_ratings rating_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_ratings ALTER COLUMN rating_id SET DEFAULT nextval('public.service_ratings_rating_id_seq'::regclass);


--
-- Name: service_zones zone_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_zones ALTER COLUMN zone_id SET DEFAULT nextval('public.service_zones_zone_id_seq'::regclass);


--
-- Name: services service_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.services ALTER COLUMN service_id SET DEFAULT nextval('public.services_service_id_seq'::regclass);


--
-- Name: sgk_declarations declaration_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.sgk_declarations ALTER COLUMN declaration_id SET DEFAULT nextval('public.sgk_declarations_declaration_id_seq'::regclass);


--
-- Name: shift_schedules schedule_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.shift_schedules ALTER COLUMN schedule_id SET DEFAULT nextval('public.shift_schedules_schedule_id_seq'::regclass);


--
-- Name: shipping_methods method_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.shipping_methods ALTER COLUMN method_id SET DEFAULT nextval('public.shipping_methods_method_id_seq'::regclass);


--
-- Name: sms_logs sms_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.sms_logs ALTER COLUMN sms_id SET DEFAULT nextval('public.sms_logs_sms_id_seq'::regclass);


--
-- Name: sms_templates template_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.sms_templates ALTER COLUMN template_id SET DEFAULT nextval('public.sms_templates_template_id_seq'::regclass);


--
-- Name: stock_count_items item_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_count_items ALTER COLUMN item_id SET DEFAULT nextval('public.stock_count_items_item_id_seq'::regclass);


--
-- Name: stock_counts count_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_counts ALTER COLUMN count_id SET DEFAULT nextval('public.stock_counts_count_id_seq'::regclass);


--
-- Name: stock_movements movement_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_movements ALTER COLUMN movement_id SET DEFAULT nextval('public.stock_movements_movement_id_seq'::regclass);


--
-- Name: subscriptions subscription_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.subscriptions ALTER COLUMN subscription_id SET DEFAULT nextval('public.subscriptions_subscription_id_seq'::regclass);


--
-- Name: suppliers supplier_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN supplier_id SET DEFAULT nextval('public.suppliers_supplier_id_seq'::regclass);


--
-- Name: survey_answers answer_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.survey_answers ALTER COLUMN answer_id SET DEFAULT nextval('public.survey_answers_answer_id_seq'::regclass);


--
-- Name: survey_questions question_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.survey_questions ALTER COLUMN question_id SET DEFAULT nextval('public.survey_questions_question_id_seq'::regclass);


--
-- Name: survey_responses response_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.survey_responses ALTER COLUMN response_id SET DEFAULT nextval('public.survey_responses_response_id_seq'::regclass);


--
-- Name: surveys survey_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.surveys ALTER COLUMN survey_id SET DEFAULT nextval('public.surveys_survey_id_seq'::regclass);


--
-- Name: system_settings setting_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.system_settings ALTER COLUMN setting_id SET DEFAULT nextval('public.system_settings_setting_id_seq'::regclass);


--
-- Name: tags tag_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.tags ALTER COLUMN tag_id SET DEFAULT nextval('public.tags_tag_id_seq'::regclass);


--
-- Name: tasks task_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.tasks ALTER COLUMN task_id SET DEFAULT nextval('public.tasks_task_id_seq'::regclass);


--
-- Name: tax_declarations declaration_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.tax_declarations ALTER COLUMN declaration_id SET DEFAULT nextval('public.tax_declarations_declaration_id_seq'::regclass);


--
-- Name: technician_locations location_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_locations ALTER COLUMN location_id SET DEFAULT nextval('public.technician_locations_location_id_seq'::regclass);


--
-- Name: technician_performance performance_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_performance ALTER COLUMN performance_id SET DEFAULT nextval('public.technician_performance_performance_id_seq'::regclass);


--
-- Name: technician_reviews review_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_reviews ALTER COLUMN review_id SET DEFAULT nextval('public.technician_reviews_review_id_seq'::regclass);


--
-- Name: technician_skill_assignments assignment_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_skill_assignments ALTER COLUMN assignment_id SET DEFAULT nextval('public.technician_skill_assignments_assignment_id_seq'::regclass);


--
-- Name: technician_skills skill_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_skills ALTER COLUMN skill_id SET DEFAULT nextval('public.technician_skills_skill_id_seq'::regclass);


--
-- Name: technician_trainings training_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_trainings ALTER COLUMN training_id SET DEFAULT nextval('public.technician_trainings_training_id_seq'::regclass);


--
-- Name: technicians technician_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technicians ALTER COLUMN technician_id SET DEFAULT nextval('public.technicians_technician_id_seq'::regclass);


--
-- Name: territories territory_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.territories ALTER COLUMN territory_id SET DEFAULT nextval('public.territories_territory_id_seq'::regclass);


--
-- Name: time_off_requests request_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.time_off_requests ALTER COLUMN request_id SET DEFAULT nextval('public.time_off_requests_request_id_seq'::regclass);


--
-- Name: training_programs program_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.training_programs ALTER COLUMN program_id SET DEFAULT nextval('public.training_programs_program_id_seq'::regclass);


--
-- Name: transfers transfer_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.transfers ALTER COLUMN transfer_id SET DEFAULT nextval('public.transfers_transfer_id_seq'::regclass);


--
-- Name: two_factor_auth tfa_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.two_factor_auth ALTER COLUMN tfa_id SET DEFAULT nextval('public.two_factor_auth_tfa_id_seq'::regclass);


--
-- Name: user_dashboard_widgets user_widget_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_dashboard_widgets ALTER COLUMN user_widget_id SET DEFAULT nextval('public.user_dashboard_widgets_user_widget_id_seq'::regclass);


--
-- Name: user_preferences preference_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_preferences ALTER COLUMN preference_id SET DEFAULT nextval('public.user_preferences_preference_id_seq'::regclass);


--
-- Name: user_sessions session_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_sessions ALTER COLUMN session_id SET DEFAULT nextval('public.user_sessions_session_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: vehicle_expenses expense_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.vehicle_expenses ALTER COLUMN expense_id SET DEFAULT nextval('public.vehicle_expenses_expense_id_seq'::regclass);


--
-- Name: vehicle_stock vehicle_stock_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.vehicle_stock ALTER COLUMN vehicle_stock_id SET DEFAULT nextval('public.vehicle_stock_vehicle_stock_id_seq'::regclass);


--
-- Name: vehicles vehicle_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.vehicles ALTER COLUMN vehicle_id SET DEFAULT nextval('public.vehicles_vehicle_id_seq'::regclass);


--
-- Name: versions version_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.versions ALTER COLUMN version_id SET DEFAULT nextval('public.versions_version_id_seq'::regclass);


--
-- Name: warehouses warehouse_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.warehouses ALTER COLUMN warehouse_id SET DEFAULT nextval('public.warehouses_warehouse_id_seq'::regclass);


--
-- Name: warranties warranty_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.warranties ALTER COLUMN warranty_id SET DEFAULT nextval('public.warranties_warranty_id_seq'::regclass);


--
-- Name: warranty_claims claim_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.warranty_claims ALTER COLUMN claim_id SET DEFAULT nextval('public.warranty_claims_claim_id_seq'::regclass);


--
-- Name: webhook_logs log_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.webhook_logs ALTER COLUMN log_id SET DEFAULT nextval('public.webhook_logs_log_id_seq'::regclass);


--
-- Name: webhooks webhook_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.webhooks ALTER COLUMN webhook_id SET DEFAULT nextval('public.webhooks_webhook_id_seq'::regclass);


--
-- Name: work_orders work_order_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.work_orders ALTER COLUMN work_order_id SET DEFAULT nextval('public.work_orders_work_order_id_seq'::regclass);


--
-- Name: workflow_steps step_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.workflow_steps ALTER COLUMN step_id SET DEFAULT nextval('public.workflow_steps_step_id_seq'::regclass);


--
-- Name: workflows workflow_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.workflows ALTER COLUMN workflow_id SET DEFAULT nextval('public.workflows_workflow_id_seq'::regclass);


--
-- Name: working_hours schedule_id; Type: DEFAULT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.working_hours ALTER COLUMN schedule_id SET DEFAULT nextval('public.working_hours_schedule_id_seq'::regclass);


--
-- Data for Name: account_transactions; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.account_transactions (transaction_id, account_id, transaction_type, transaction_date, amount, balance_after, reference_type, reference_id, description, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.accounts (account_id, account_type, account_name, bank_name, iban, currency, current_balance, status, created_at) FROM stdin;
\.


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.activity_logs (log_id, user_id, action, entity_type, entity_id, old_values, new_values, ip_address, user_agent, created_at) FROM stdin;
\.


--
-- Data for Name: advance_payments; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.advance_payments (advance_id, entity_type, entity_id, amount, payment_date, payment_method, account_id, remaining_amount, status, notes, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: api_keys; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.api_keys (key_id, service_name, api_key, api_secret, endpoint_url, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: api_rate_limits; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.api_rate_limits (limit_id, api_key_id, endpoint, max_requests, time_window_seconds, current_count, window_start, is_active) FROM stdin;
\.


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.appointments (appointment_id, customer_id, device_id, appointment_date, appointment_time, appointment_type, priority, status, assigned_technician_id, estimated_duration, notes, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: approvals; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.approvals (approval_id, entity_type, entity_id, approval_type, requested_by, requested_at, approved_by, approved_at, status, comments) FROM stdin;
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.assets (asset_id, asset_code, asset_name, asset_category, purchase_date, purchase_price, current_value, depreciation_method, useful_life_years, salvage_value, location, assigned_to, status, notes, created_at) FROM stdin;
\.


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.attachments (attachment_id, entity_type, entity_id, file_id, attachment_type, description, uploaded_by, created_at) FROM stdin;
\.


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.attendance (attendance_id, employee_id, technician_id, attendance_date, check_in_time, check_out_time, total_hours, status, notes, created_at) FROM stdin;
\.


--
-- Data for Name: audit_trail; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.audit_trail (audit_id, user_id, action, entity_type, entity_id, old_values, new_values, changes, ip_address, user_agent, session_id, created_at) FROM stdin;
\.


--
-- Data for Name: automation_rules; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.automation_rules (rule_id, rule_name, entity_type, trigger_event, conditions, actions, is_active, last_run_at, run_count, created_at) FROM stdin;
\.


--
-- Data for Name: backup_logs; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.backup_logs (backup_id, backup_date, backup_type, file_path, file_size, status, created_at) FROM stdin;
\.


--
-- Data for Name: bank_reconciliation; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.bank_reconciliation (reconciliation_id, account_id, reconciliation_date, statement_balance, book_balance, difference, status, reconciled_by, notes, created_at) FROM stdin;
\.


--
-- Data for Name: bank_reconciliation_items; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.bank_reconciliation_items (item_id, reconciliation_id, transaction_id, is_matched, difference_amount, notes) FROM stdin;
\.


--
-- Data for Name: bookmarks; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.bookmarks (bookmark_id, user_id, entity_type, entity_id, bookmark_name, notes, created_at) FROM stdin;
\.


--
-- Data for Name: budgets; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.budgets (budget_id, budget_year, budget_month, category_id, planned_amount, actual_amount, variance, notes) FROM stdin;
\.


--
-- Data for Name: call_recordings; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.call_recordings (recording_id, call_id, file_path, duration, created_at) FROM stdin;
\.


--
-- Data for Name: calls; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.calls (call_id, customer_id, phone_number, call_type, call_date, call_duration, handled_by, call_result, notes, created_at) FROM stdin;
\.


--
-- Data for Name: campaigns; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.campaigns (campaign_id, campaign_name, campaign_type, start_date, end_date, discount_type, discount_value, target_segment, status, created_at) FROM stdin;
\.


--
-- Data for Name: capacity_planning; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.capacity_planning (date, available_technicians, total_appointments, capacity_percentage) FROM stdin;
\.


--
-- Data for Name: certifications; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.certifications (certification_id, technician_id, certification_name, issuing_authority, issue_date, expiry_date, certificate_number, status) FROM stdin;
\.


--
-- Data for Name: checks; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.checks (check_id, check_type, check_number, bank_name, branch, account_number, amount, issue_date, due_date, customer_id, supplier_id, status, notes, created_at) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.comments (comment_id, entity_type, entity_id, comment_text, parent_comment_id, created_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: commissions; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.commissions (commission_id, employee_id, technician_id, period_month, period_year, commission_type, base_amount, commission_rate, commission_amount, status, paid_date, notes, created_at) FROM stdin;
\.


--
-- Data for Name: communication_logs; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.communication_logs (log_id, customer_id, communication_type, direction, subject, content, status, contacted_by, created_at) FROM stdin;
\.


--
-- Data for Name: complaints; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.complaints (complaint_id, customer_id, service_id, complaint_date, complaint_type, description, priority, status, assigned_to, resolution, resolved_date, customer_satisfaction, created_at) FROM stdin;
\.


--
-- Data for Name: contract_services; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.contract_services (contract_service_id, contract_id, service_id, scheduled_date, completed_date, status) FROM stdin;
\.


--
-- Data for Name: contracts; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.contracts (contract_id, customer_id, device_id, contract_type, start_date, end_date, renewal_date, service_frequency, contract_amount, payment_frequency, included_services, status, auto_renewal, created_at) FROM stdin;
\.


--
-- Data for Name: coupon_usage; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.coupon_usage (usage_id, coupon_id, customer_id, invoice_id, discount_amount, used_at) FROM stdin;
\.


--
-- Data for Name: coupons; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.coupons (coupon_id, coupon_code, discount_type, discount_value, min_purchase_amount, max_discount_amount, usage_limit_per_customer, total_usage_limit, valid_from, valid_until, applicable_services, status) FROM stdin;
\.


--
-- Data for Name: credit_limits; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.credit_limits (limit_id, customer_id, credit_limit, used_credit, available_credit, payment_terms, grace_period_days, interest_rate, last_review_date, next_review_date, status) FROM stdin;
\.


--
-- Data for Name: credit_note_items; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.credit_note_items (item_id, credit_note_id, description, quantity, unit_price, tax_rate, total_price) FROM stdin;
\.


--
-- Data for Name: credit_notes; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.credit_notes (credit_note_id, credit_note_number, invoice_id, customer_id, credit_date, reason, subtotal, tax_amount, total_amount, status, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: current_account_transactions; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.current_account_transactions (transaction_id, account_id, transaction_type, transaction_date, amount, balance_after, reference_type, reference_id, description, created_at) FROM stdin;
\.


--
-- Data for Name: current_accounts; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.current_accounts (account_id, account_type, entity_id, balance, credit_limit, last_transaction_date, created_at) FROM stdin;
\.


--
-- Data for Name: customer_addresses; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.customer_addresses (address_id, customer_id, address_type, address_line1, address_line2, city, district, postal_code, country, is_default, latitude, longitude, notes, created_at) FROM stdin;
\.


--
-- Data for Name: customer_contacts; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.customer_contacts (contact_id, customer_id, name, title, phone, email, is_primary) FROM stdin;
\.


--
-- Data for Name: customer_notes; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.customer_notes (note_id, customer_id, note_type, note, is_pinned, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: customer_preferences; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.customer_preferences (preference_id, customer_id, preferred_contact_method, preferred_contact_time, language_preference, timezone, receive_marketing, receive_reminders, receive_surveys) FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.customers (customer_id, customer_type, first_name, last_name, company_name, tax_number, tax_office, phone, email, address, city, district, postal_code, loyalty_points, customer_segment, notes, status, created_at, updated_at, deleted_at, vat_number, website, industry, company_size, annual_revenue, source, assigned_sales_rep, preferred_contact_method, language_preference, timezone, customer_since, total_services_count, total_spent) FROM stdin;
1	\N	\N	\N	\N	\N	\N	05326547573	Melihcanakin@gmail.com	Girne	tekirdap	çerkezköy	\N	0	\N	\N	active	2025-11-09 09:12:40.171284	2025-11-09 09:12:40.171284	\N	\N	\N	\N	\N	\N	\N	\N	\N	tr	Europe/Istanbul	2025-11-09	0	0.00
\.


--
-- Data for Name: dashboard_widgets; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.dashboard_widgets (widget_id, widget_name, widget_type, widget_config, position_x, position_y, width, height, is_active) FROM stdin;
\.


--
-- Data for Name: data_exports; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.data_exports (export_id, export_name, export_type, entity_type, filters, file_path, file_size, row_count, status, requested_by, created_at, completed_at) FROM stdin;
\.


--
-- Data for Name: debit_notes; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.debit_notes (debit_note_id, debit_note_number, invoice_id, customer_id, debit_date, reason, amount, status, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: depreciation; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.depreciation (depreciation_id, asset_id, period_month, period_year, depreciation_amount, accumulated_depreciation, book_value, calculated_at) FROM stdin;
\.


--
-- Data for Name: device_documents; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.device_documents (document_id, device_id, document_type, title, file_id, issue_date, expiry_date, notes, created_at) FROM stdin;
\.


--
-- Data for Name: device_history; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.device_history (history_id, device_id, event_type, event_date, description, technician_id, created_at) FROM stdin;
\.


--
-- Data for Name: device_parts; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.device_parts (device_part_id, device_id, part_id, installation_date, installed_by, warranty_end_date, status, notes, created_at) FROM stdin;
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.devices (device_id, customer_id, brand, model, serial_number, installation_date, warranty_start_date, warranty_end_date, last_maintenance_date, next_maintenance_date, device_status, location_notes, qr_code, created_at, updated_at, purchase_date, purchase_price, current_value, condition, power_consumption, efficiency_rating, last_inspection_date, next_inspection_date, manual_url, parts_catalog_url, last_service_date, total_service_count, warranty_status, notes) FROM stdin;
\.


--
-- Data for Name: discount_codes; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.discount_codes (code_id, code, campaign_id, discount_type, discount_value, usage_limit, used_count, valid_from, valid_until, status) FROM stdin;
\.


--
-- Data for Name: document_photos; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.document_photos (photo_id, entity_type, entity_id, file_id, document_type, description, scan_date, scanned_by) FROM stdin;
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.documents (document_id, document_type, title, description, file_id, related_entity_type, related_entity_id, version, status, created_at) FROM stdin;
\.


--
-- Data for Name: email_logs; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.email_logs (email_id, recipient_email, subject, body, status, sent_at) FROM stdin;
\.


--
-- Data for Name: email_templates; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.email_templates (template_id, template_name, subject, body_html, body_text, variables, category, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: emergency_contacts; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.emergency_contacts (contact_id, employee_id, technician_id, contact_name, relationship, phone, alternate_phone, address, is_primary) FROM stdin;
\.


--
-- Data for Name: employee_documents; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.employee_documents (document_id, employee_id, document_type, title, file_id, issue_date, expiry_date, issuing_authority, document_number, notes, created_at) FROM stdin;
\.


--
-- Data for Name: employee_shifts; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.employee_shifts (assignment_id, employee_id, technician_id, schedule_id, shift_date, status) FROM stdin;
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.employees (employee_id, user_id, first_name, last_name, phone, email, "position", department, hire_date, salary, status, created_at) FROM stdin;
\.


--
-- Data for Name: entity_tags; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.entity_tags (entity_tag_id, entity_type, entity_id, tag_id, created_at) FROM stdin;
\.


--
-- Data for Name: exchange_rates; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.exchange_rates (rate_id, currency_code, rate, rate_date, created_at) FROM stdin;
\.


--
-- Data for Name: expense_categories; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.expense_categories (category_id, category_name, parent_category_id, budget_limit, requires_approval) FROM stdin;
\.


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.expenses (expense_id, expense_category_id, expense_date, amount, payment_method, account_id, supplier_id, description, receipt_number, tax_amount, approval_status, approved_by, approved_at, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.failed_jobs (failed_job_id, queue_name, job_type, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: fault_codes; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.fault_codes (code_id, code, device_type, description, common_causes, recommended_parts, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.files (file_id, entity_type, entity_id, file_name, original_name, file_path, file_type, category, mime_type, size, uploaded_by, created_at) FROM stdin;
\.


--
-- Data for Name: holidays; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.holidays (holiday_id, holiday_name, holiday_date, holiday_type, is_recurring, description) FROM stdin;
\.


--
-- Data for Name: installment_plans; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.installment_plans (plan_id, invoice_id, total_installments, installment_amount, interest_rate, created_at) FROM stdin;
\.


--
-- Data for Name: installments; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.installments (installment_id, plan_id, installment_number, due_date, amount, paid_amount, payment_date, status) FROM stdin;
\.


--
-- Data for Name: insurance_policies; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.insurance_policies (policy_id, policy_type, policy_number, insurance_company, insured_type, insured_id, coverage_amount, premium_amount, premium_frequency, start_date, end_date, renewal_date, status, file_id, notes, created_at) FROM stdin;
\.


--
-- Data for Name: integration_logs; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.integration_logs (log_id, integration_type, request_data, response_data, status, error_message, created_at) FROM stdin;
\.


--
-- Data for Name: internal_messages; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.internal_messages (message_id, sender_id, recipient_id, subject, message, is_read, read_at, parent_message_id, created_at) FROM stdin;
\.


--
-- Data for Name: inventory_adjustment_items; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.inventory_adjustment_items (item_id, adjustment_id, part_id, warehouse_id, quantity_before, quantity_after, quantity_change, unit_cost, total_cost) FROM stdin;
\.


--
-- Data for Name: inventory_adjustments; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.inventory_adjustments (adjustment_id, adjustment_date, adjustment_type, reason, notes, status, approved_by, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: invoice_items; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.invoice_items (item_id, invoice_id, item_type, description, quantity, unit_price, tax_rate, discount_rate, total_price) FROM stdin;
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.invoices (invoice_id, invoice_number, invoice_type, customer_id, service_id, invoice_date, due_date, subtotal, tax_amount, discount_amount, total_amount, payment_status, paid_amount, notes, e_invoice_uuid, created_at, currency, exchange_rate, payment_terms, bank_account_id, late_fee, interest_rate, reminder_sent_count, last_reminder_date) FROM stdin;
\.


--
-- Data for Name: ip_whitelist; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.ip_whitelist (whitelist_id, ip_address, description, is_active, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: kpi_metrics; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.kpi_metrics (metric_id, metric_name, metric_type, target_value, actual_value, period_month, period_year, calculated_at) FROM stdin;
\.


--
-- Data for Name: leaves; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.leaves (leave_id, employee_id, technician_id, leave_type, start_date, end_date, total_days, reason, status, approved_by, approved_at, notes, created_at) FROM stdin;
\.


--
-- Data for Name: licenses; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.licenses (license_id, license_type, license_name, license_number, issuing_authority, issue_date, expiry_date, renewal_date, cost, assigned_to_type, assigned_to_id, status, file_id, notes, created_at) FROM stdin;
\.


--
-- Data for Name: login_attempts; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.login_attempts (attempt_id, username, ip_address, user_agent, success, failure_reason, attempted_at) FROM stdin;
\.


--
-- Data for Name: maintenance_schedules; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.maintenance_schedules (schedule_id, device_id, frequency_type, frequency_value, last_service_date, next_service_date, auto_create_appointment, notification_days_before, status) FROM stdin;
\.


--
-- Data for Name: marketing_messages; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.marketing_messages (message_id, campaign_id, message_type, subject, content, target_segment, scheduled_date, sent_date, recipient_count, status, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.migrations (migration_id, migration_name, batch, executed_at) FROM stdin;
\.


--
-- Data for Name: notification_preferences; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.notification_preferences (preference_id, user_id, email_enabled, sms_enabled, push_enabled, appointment_reminders, payment_reminders, maintenance_reminders, marketing_messages, system_notifications) FROM stdin;
\.


--
-- Data for Name: notification_templates; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.notification_templates (template_id, template_name, template_type, event_trigger, subject, body, variables, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.notifications (notification_id, user_id, notification_type, title, message, is_read, created_at) FROM stdin;
\.


--
-- Data for Name: overtime; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.overtime (overtime_id, employee_id, technician_id, overtime_date, start_time, end_time, total_hours, overtime_rate, amount, status, approved_by, notes, created_at) FROM stdin;
\.


--
-- Data for Name: part_photos; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.part_photos (photo_id, part_id, file_id, photo_type, is_primary, display_order, created_at) FROM stdin;
\.


--
-- Data for Name: part_returns; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.part_returns (return_id, service_part_id, return_date, reason, refund_amount, status, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: part_suppliers; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.part_suppliers (part_supplier_id, part_id, supplier_id, supplier_part_code, unit_price, minimum_order_quantity, lead_time_days, is_preferred, last_purchase_date, last_purchase_price, notes) FROM stdin;
\.


--
-- Data for Name: partner_current_accounts; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.partner_current_accounts (account_id, partner_id, current_balance, last_updated) FROM stdin;
\.


--
-- Data for Name: partner_transactions; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.partner_transactions (transaction_id, partner_id, transaction_type, transaction_date, amount, account_id, description, approved_by, created_at) FROM stdin;
\.


--
-- Data for Name: partners; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.partners (partner_id, partner_name, tax_number, phone, email, share_percentage, investment_amount, join_date, status, created_at) FROM stdin;
\.


--
-- Data for Name: parts; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.parts (part_id, part_code, part_name, category, brand, model_compatibility, unit, unit_price, sale_price, minimum_stock, reorder_quantity, supplier_id, status, created_at, updated_at, barcode, sku, weight, dimensions, location, bin_number, shelf_number, critical, lead_time, last_purchase_date, last_purchase_price, average_cost, image_url, warranty_period) FROM stdin;
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.password_resets (reset_id, user_id, reset_token, expires_at, used_at, ip_address, created_at) FROM stdin;
\.


--
-- Data for Name: payment_plan_installments; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.payment_plan_installments (installment_id, plan_id, installment_number, due_date, amount, paid_date, status, created_at) FROM stdin;
\.


--
-- Data for Name: payment_plans; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.payment_plans (plan_id, service_id, customer_id, total_amount, installment_count, installment_amount, paid_installments, status, created_at) FROM stdin;
\.


--
-- Data for Name: payment_terms; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.payment_terms (term_id, term_name, days, discount_percentage, discount_days, description, is_active) FROM stdin;
\.


--
-- Data for Name: payments_received; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.payments_received (payment_id, invoice_id, customer_id, payment_date, payment_method, amount, account_id, reference_number, notes, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.permissions (permission_id, permission_name, module, action, description) FROM stdin;
\.


--
-- Data for Name: petty_cash; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.petty_cash (transaction_id, transaction_date, transaction_type, amount, category, description, receipt_number, handled_by, approved_by, created_at) FROM stdin;
\.


--
-- Data for Name: price_history; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.price_history (history_id, part_id, old_price, new_price, change_date, changed_by, reason) FROM stdin;
\.


--
-- Data for Name: price_list_items; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.price_list_items (item_id, price_list_id, part_id, price, discount_percentage) FROM stdin;
\.


--
-- Data for Name: price_lists; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.price_lists (price_list_id, list_name, valid_from, valid_until, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: promissory_notes; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.promissory_notes (note_id, note_type, note_number, amount, issue_date, due_date, customer_id, supplier_id, endorsement_count, status, notes, created_at) FROM stdin;
\.


--
-- Data for Name: purchase_order_items; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.purchase_order_items (item_id, order_id, part_id, quantity, unit_price, total_price) FROM stdin;
\.


--
-- Data for Name: purchase_orders; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.purchase_orders (order_id, supplier_id, order_date, expected_delivery_date, actual_delivery_date, total_amount, status, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: queue_jobs; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.queue_jobs (job_id, queue_name, job_type, payload, attempts, max_attempts, status, available_at, started_at, completed_at, created_at) FROM stdin;
\.


--
-- Data for Name: quotation_items; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.quotation_items (item_id, quotation_id, item_type, description, quantity, unit_price, tax_rate, discount_rate, total_price) FROM stdin;
\.


--
-- Data for Name: quotations; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.quotations (quotation_id, quotation_number, customer_id, device_id, quotation_date, valid_until, subtotal, tax_amount, discount_amount, total_amount, status, notes, terms_conditions, created_by, created_at, converted_to_invoice_id) FROM stdin;
\.


--
-- Data for Name: recurring_invoices; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.recurring_invoices (recurring_invoice_id, customer_id, contract_id, frequency, start_date, end_date, next_invoice_date, last_invoice_date, invoice_template, auto_send, status, created_at) FROM stdin;
\.


--
-- Data for Name: referrals; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.referrals (referral_id, referrer_customer_id, referred_customer_id, referral_date, first_service_date, reward_type, reward_amount, reward_status, created_at) FROM stdin;
\.


--
-- Data for Name: reminders; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.reminders (reminder_id, reminder_type, entity_type, entity_id, reminder_date, message, status, sent_at, created_at) FROM stdin;
\.


--
-- Data for Name: report_schedules; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.report_schedules (schedule_id, report_name, report_type, frequency, schedule_time, schedule_day, recipients, parameters, format, is_active, last_run_at, next_run_at, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: return_request_items; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.return_request_items (item_id, return_id, part_id, quantity, unit_price, total_price, condition) FROM stdin;
\.


--
-- Data for Name: return_requests; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.return_requests (return_id, return_number, invoice_id, customer_id, return_date, return_reason, description, status, refund_amount, refund_method, approved_by, created_at) FROM stdin;
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.role_permissions (role_id, permission_id) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.roles (role_id, role_name, description, created_at) FROM stdin;
\.


--
-- Data for Name: route_stops; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.route_stops (stop_id, route_id, appointment_id, stop_order, estimated_arrival, actual_arrival, estimated_departure, actual_departure, latitude, longitude, status) FROM stdin;
\.


--
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.routes (route_id, technician_id, route_date, start_time, end_time, total_distance, total_duration, status, created_at) FROM stdin;
\.


--
-- Data for Name: salaries; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.salaries (salary_id, employee_id, period_month, period_year, base_salary, bonus, deductions, net_salary, payment_date, payment_method, account_id, status, created_at) FROM stdin;
\.


--
-- Data for Name: saved_filters; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.saved_filters (filter_id, user_id, filter_name, entity_type, filter_config, is_default, is_public, created_at) FROM stdin;
\.


--
-- Data for Name: scheduled_jobs; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.scheduled_jobs (job_id, job_name, job_type, schedule_expression, last_run_at, next_run_at, status, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: scheduled_maintenance_history; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.scheduled_maintenance_history (history_id, schedule_id, appointment_id, scheduled_date, completed_date, status) FROM stdin;
\.


--
-- Data for Name: service_area_pricing; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.service_area_pricing (pricing_id, area_id, service_type, base_price, travel_fee) FROM stdin;
\.


--
-- Data for Name: service_areas; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.service_areas (area_id, area_name, city, districts, assigned_technician_id, is_active) FROM stdin;
\.


--
-- Data for Name: service_checklist_items; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.service_checklist_items (item_id, template_id, item_text, item_order, is_required, expected_value) FROM stdin;
\.


--
-- Data for Name: service_checklist_responses; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.service_checklist_responses (response_id, checklist_id, item_id, is_checked, actual_value, notes, checked_at) FROM stdin;
\.


--
-- Data for Name: service_checklist_templates; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.service_checklist_templates (template_id, template_name, service_type, description, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: service_checklists; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.service_checklists (checklist_id, service_id, template_id, created_at) FROM stdin;
\.


--
-- Data for Name: service_parts; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.service_parts (service_part_id, service_id, part_id, quantity, unit_price, total_price, warranty_months) FROM stdin;
\.


--
-- Data for Name: service_photos; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.service_photos (photo_id, service_id, file_id, photo_type, category, description, latitude, longitude, taken_at, taken_by, is_customer_visible, display_order) FROM stdin;
\.


--
-- Data for Name: service_ratings; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.service_ratings (rating_id, service_id, overall_rating, technician_rating, quality_rating, timeliness_rating, communication_rating, cleanliness_rating, would_recommend, feedback, rated_at) FROM stdin;
\.


--
-- Data for Name: service_zones; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.service_zones (zone_id, zone_name, cities, districts, default_technician_id, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.services (service_id, appointment_id, customer_id, device_id, technician_id, service_type, service_date, start_time, end_time, problem_description, solution_description, status, customer_signature, technician_notes, customer_rating, customer_feedback, total_cost, labor_cost, parts_cost, created_at, updated_at, completed_at, scheduled_date, actual_date, travel_time, travel_distance, travel_cost, discount_amount, tax_amount, payment_status, invoice_id, warranty_work, follow_up_required, follow_up_date, priority, estimated_duration, before_photos, after_photos) FROM stdin;
\.


--
-- Data for Name: sgk_declarations; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.sgk_declarations (declaration_id, period_month, period_year, employee_count, total_premium, declaration_date, payment_date, status) FROM stdin;
\.


--
-- Data for Name: shift_schedules; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.shift_schedules (schedule_id, schedule_name, shift_type, start_time, end_time, break_duration, is_active) FROM stdin;
\.


--
-- Data for Name: shipping_methods; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.shipping_methods (method_id, method_name, carrier, estimated_days, cost, is_active) FROM stdin;
\.


--
-- Data for Name: sms_logs; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.sms_logs (sms_id, phone_number, message, status, sent_at, cost) FROM stdin;
\.


--
-- Data for Name: sms_templates; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.sms_templates (template_id, template_name, message, variables, category, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: stock_count_items; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.stock_count_items (item_id, count_id, part_id, system_quantity, counted_quantity, difference, notes) FROM stdin;
\.


--
-- Data for Name: stock_counts; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.stock_counts (count_id, warehouse_id, count_date, counted_by, status, notes, created_at) FROM stdin;
\.


--
-- Data for Name: stock_movements; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.stock_movements (movement_id, part_id, warehouse_id, movement_type, quantity, unit_price, reference_type, reference_id, notes, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.subscriptions (subscription_id, service_name, provider, subscription_type, start_date, end_date, renewal_date, cost, billing_frequency, auto_renewal, status, notes, created_at) FROM stdin;
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.suppliers (supplier_id, supplier_name, contact_person, phone, email, address, tax_number, payment_terms, status, created_at) FROM stdin;
\.


--
-- Data for Name: survey_answers; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.survey_answers (answer_id, response_id, question_id, answer_value) FROM stdin;
\.


--
-- Data for Name: survey_questions; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.survey_questions (question_id, survey_id, question_text, question_type, is_required, order_number) FROM stdin;
\.


--
-- Data for Name: survey_responses; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.survey_responses (response_id, survey_id, service_id, customer_id, submitted_at) FROM stdin;
\.


--
-- Data for Name: surveys; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.surveys (survey_id, survey_name, description, status, created_at) FROM stdin;
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.system_settings (setting_id, setting_key, setting_value, setting_type, description, updated_by, updated_at) FROM stdin;
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.tags (tag_id, tag_name, tag_color, tag_category, created_at) FROM stdin;
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.tasks (task_id, task_title, description, assigned_to, created_by, priority, due_date, status, related_entity_type, related_entity_id, created_at, completed_at) FROM stdin;
\.


--
-- Data for Name: tax_declarations; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.tax_declarations (declaration_id, declaration_type, period_month, period_year, total_income, total_expense, tax_base, tax_amount, declaration_date, payment_date, status) FROM stdin;
\.


--
-- Data for Name: technician_locations; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.technician_locations (location_id, technician_id, latitude, longitude, accuracy, speed, "timestamp") FROM stdin;
\.


--
-- Data for Name: technician_performance; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.technician_performance (performance_id, technician_id, period_month, period_year, completed_services, average_rating, total_revenue, customer_complaints, on_time_percentage) FROM stdin;
\.


--
-- Data for Name: technician_reviews; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.technician_reviews (review_id, technician_id, service_id, customer_id, rating, review_text, is_public, created_at) FROM stdin;
\.


--
-- Data for Name: technician_skill_assignments; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.technician_skill_assignments (assignment_id, technician_id, skill_id, proficiency_level, years_experience, certified, certification_date, notes) FROM stdin;
\.


--
-- Data for Name: technician_skills; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.technician_skills (skill_id, skill_name, skill_category, description) FROM stdin;
\.


--
-- Data for Name: technician_trainings; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.technician_trainings (training_id, technician_id, program_id, training_date, completion_date, score, certificate_number, expiry_date, status) FROM stdin;
\.


--
-- Data for Name: technicians; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.technicians (technician_id, user_id, first_name, last_name, phone, email, specialization, experience_years, hourly_rate, vehicle_id, status, created_at, employee_number, national_id, birth_date, hire_date, termination_date, emergency_contact_name, emergency_contact_phone, address, city, license_number, license_expiry, uniform_size, tools_assigned) FROM stdin;
\.


--
-- Data for Name: territories; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.territories (territory_id, territory_name, territory_code, parent_territory_id, manager_id, cities, districts, postal_codes, description, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: time_off_requests; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.time_off_requests (request_id, technician_id, start_date, end_date, reason, status, approved_by, created_at) FROM stdin;
\.


--
-- Data for Name: training_programs; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.training_programs (program_id, program_name, description, duration_hours, cost, status) FROM stdin;
\.


--
-- Data for Name: transfers; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.transfers (transfer_id, from_account_id, to_account_id, amount, transfer_date, description, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: two_factor_auth; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.two_factor_auth (tfa_id, user_id, secret_key, is_enabled, backup_codes, enabled_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: user_dashboard_widgets; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.user_dashboard_widgets (user_widget_id, user_id, widget_id, position_x, position_y, width, height, custom_config) FROM stdin;
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.user_preferences (preference_id, user_id, theme, language, timezone, date_format, time_format, currency, items_per_page, preferences, updated_at) FROM stdin;
\.


--
-- Data for Name: user_sessions; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.user_sessions (session_id, user_id, session_token, ip_address, user_agent, device_type, device_name, login_at, last_activity_at, logout_at, is_active) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.users (user_id, username, email, password_hash, role_id, status, last_login, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: vehicle_expenses; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.vehicle_expenses (expense_id, vehicle_id, expense_type, expense_date, amount, odometer_reading, description, receipt_path, created_at) FROM stdin;
\.


--
-- Data for Name: vehicle_stock; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.vehicle_stock (vehicle_stock_id, technician_id, part_id, quantity, last_updated) FROM stdin;
\.


--
-- Data for Name: vehicles; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.vehicles (vehicle_id, plate_number, brand, model, year, assigned_technician_id, insurance_company, insurance_expiry, inspection_expiry, status, created_at) FROM stdin;
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.versions (version_id, entity_type, entity_id, version_number, data, change_summary, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: warehouses; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.warehouses (warehouse_id, warehouse_name, warehouse_type, address, responsible_person, status) FROM stdin;
\.


--
-- Data for Name: warranties; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.warranties (warranty_id, warranty_type, entity_type, entity_id, start_date, end_date, warranty_terms, provider, status) FROM stdin;
\.


--
-- Data for Name: warranty_claims; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.warranty_claims (claim_id, warranty_id, claim_date, issue_description, resolution, claim_status, resolved_date) FROM stdin;
\.


--
-- Data for Name: webhook_logs; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.webhook_logs (log_id, webhook_id, event_type, payload, response_status, response_body, attempt_number, triggered_at) FROM stdin;
\.


--
-- Data for Name: webhooks; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.webhooks (webhook_id, webhook_name, url, event_type, secret_key, is_active, retry_count, timeout_seconds, last_triggered_at, created_at) FROM stdin;
\.


--
-- Data for Name: work_orders; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.work_orders (work_order_id, work_order_number, service_id, quotation_id, assigned_technician_id, priority, status, scheduled_date, completed_date, instructions, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: workflow_steps; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.workflow_steps (step_id, workflow_id, step_order, step_name, step_type, step_config, is_required) FROM stdin;
\.


--
-- Data for Name: workflows; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.workflows (workflow_id, workflow_name, workflow_type, description, trigger_event, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: working_hours; Type: TABLE DATA; Schema: public; Owner: akinadmin
--

COPY public.working_hours (schedule_id, technician_id, day_of_week, start_time, end_time, is_available) FROM stdin;
\.


--
-- Name: account_transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.account_transactions_transaction_id_seq', 1, false);


--
-- Name: accounts_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.accounts_account_id_seq', 1, false);


--
-- Name: activity_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.activity_logs_log_id_seq', 1, false);


--
-- Name: advance_payments_advance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.advance_payments_advance_id_seq', 1, false);


--
-- Name: api_keys_key_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.api_keys_key_id_seq', 1, false);


--
-- Name: api_rate_limits_limit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.api_rate_limits_limit_id_seq', 1, false);


--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.appointments_appointment_id_seq', 1, false);


--
-- Name: approvals_approval_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.approvals_approval_id_seq', 1, false);


--
-- Name: assets_asset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.assets_asset_id_seq', 1, false);


--
-- Name: attachments_attachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.attachments_attachment_id_seq', 1, false);


--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.attendance_attendance_id_seq', 1, false);


--
-- Name: audit_trail_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.audit_trail_audit_id_seq', 1, false);


--
-- Name: automation_rules_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.automation_rules_rule_id_seq', 1, false);


--
-- Name: backup_logs_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.backup_logs_backup_id_seq', 1, false);


--
-- Name: bank_reconciliation_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.bank_reconciliation_items_item_id_seq', 1, false);


--
-- Name: bank_reconciliation_reconciliation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.bank_reconciliation_reconciliation_id_seq', 1, false);


--
-- Name: bookmarks_bookmark_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.bookmarks_bookmark_id_seq', 1, false);


--
-- Name: budgets_budget_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.budgets_budget_id_seq', 1, false);


--
-- Name: call_recordings_recording_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.call_recordings_recording_id_seq', 1, false);


--
-- Name: calls_call_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.calls_call_id_seq', 1, false);


--
-- Name: campaigns_campaign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.campaigns_campaign_id_seq', 1, false);


--
-- Name: certifications_certification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.certifications_certification_id_seq', 1, false);


--
-- Name: checks_check_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.checks_check_id_seq', 1, false);


--
-- Name: comments_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.comments_comment_id_seq', 1, false);


--
-- Name: commissions_commission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.commissions_commission_id_seq', 1, false);


--
-- Name: communication_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.communication_logs_log_id_seq', 1, false);


--
-- Name: complaints_complaint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.complaints_complaint_id_seq', 1, false);


--
-- Name: contract_services_contract_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.contract_services_contract_service_id_seq', 1, false);


--
-- Name: contracts_contract_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.contracts_contract_id_seq', 1, false);


--
-- Name: coupon_usage_usage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.coupon_usage_usage_id_seq', 1, false);


--
-- Name: coupons_coupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.coupons_coupon_id_seq', 1, false);


--
-- Name: credit_limits_limit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.credit_limits_limit_id_seq', 1, false);


--
-- Name: credit_note_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.credit_note_items_item_id_seq', 1, false);


--
-- Name: credit_notes_credit_note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.credit_notes_credit_note_id_seq', 1, false);


--
-- Name: current_account_transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.current_account_transactions_transaction_id_seq', 1, false);


--
-- Name: current_accounts_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.current_accounts_account_id_seq', 1, false);


--
-- Name: customer_addresses_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.customer_addresses_address_id_seq', 1, false);


--
-- Name: customer_contacts_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.customer_contacts_contact_id_seq', 1, false);


--
-- Name: customer_notes_note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.customer_notes_note_id_seq', 1, false);


--
-- Name: customer_preferences_preference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.customer_preferences_preference_id_seq', 1, false);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 1, true);


--
-- Name: dashboard_widgets_widget_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.dashboard_widgets_widget_id_seq', 1, false);


--
-- Name: data_exports_export_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.data_exports_export_id_seq', 1, false);


--
-- Name: debit_notes_debit_note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.debit_notes_debit_note_id_seq', 1, false);


--
-- Name: depreciation_depreciation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.depreciation_depreciation_id_seq', 1, false);


--
-- Name: device_documents_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.device_documents_document_id_seq', 1, false);


--
-- Name: device_history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.device_history_history_id_seq', 1, false);


--
-- Name: device_parts_device_part_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.device_parts_device_part_id_seq', 1, false);


--
-- Name: devices_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.devices_device_id_seq', 1, false);


--
-- Name: discount_codes_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.discount_codes_code_id_seq', 1, false);


--
-- Name: document_photos_photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.document_photos_photo_id_seq', 1, false);


--
-- Name: documents_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.documents_document_id_seq', 1, false);


--
-- Name: email_logs_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.email_logs_email_id_seq', 1, false);


--
-- Name: email_templates_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.email_templates_template_id_seq', 1, false);


--
-- Name: emergency_contacts_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.emergency_contacts_contact_id_seq', 1, false);


--
-- Name: employee_documents_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.employee_documents_document_id_seq', 1, false);


--
-- Name: employee_shifts_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.employee_shifts_assignment_id_seq', 1, false);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 1, false);


--
-- Name: entity_tags_entity_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.entity_tags_entity_tag_id_seq', 1, false);


--
-- Name: exchange_rates_rate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.exchange_rates_rate_id_seq', 1, false);


--
-- Name: expense_categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.expense_categories_category_id_seq', 1, false);


--
-- Name: expenses_expense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.expenses_expense_id_seq', 1, false);


--
-- Name: failed_jobs_failed_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.failed_jobs_failed_job_id_seq', 1, false);


--
-- Name: fault_codes_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.fault_codes_code_id_seq', 1, false);


--
-- Name: files_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.files_file_id_seq', 1, false);


--
-- Name: holidays_holiday_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.holidays_holiday_id_seq', 1, false);


--
-- Name: installment_plans_plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.installment_plans_plan_id_seq', 1, false);


--
-- Name: installments_installment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.installments_installment_id_seq', 1, false);


--
-- Name: insurance_policies_policy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.insurance_policies_policy_id_seq', 1, false);


--
-- Name: integration_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.integration_logs_log_id_seq', 1, false);


--
-- Name: internal_messages_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.internal_messages_message_id_seq', 1, false);


--
-- Name: inventory_adjustment_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.inventory_adjustment_items_item_id_seq', 1, false);


--
-- Name: inventory_adjustments_adjustment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.inventory_adjustments_adjustment_id_seq', 1, false);


--
-- Name: invoice_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.invoice_items_item_id_seq', 1, false);


--
-- Name: invoices_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.invoices_invoice_id_seq', 1, false);


--
-- Name: ip_whitelist_whitelist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.ip_whitelist_whitelist_id_seq', 1, false);


--
-- Name: kpi_metrics_metric_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.kpi_metrics_metric_id_seq', 1, false);


--
-- Name: leaves_leave_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.leaves_leave_id_seq', 1, false);


--
-- Name: licenses_license_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.licenses_license_id_seq', 1, false);


--
-- Name: login_attempts_attempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.login_attempts_attempt_id_seq', 1, false);


--
-- Name: maintenance_schedules_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.maintenance_schedules_schedule_id_seq', 1, false);


--
-- Name: marketing_messages_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.marketing_messages_message_id_seq', 1, false);


--
-- Name: migrations_migration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.migrations_migration_id_seq', 1, false);


--
-- Name: notification_preferences_preference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.notification_preferences_preference_id_seq', 1, false);


--
-- Name: notification_templates_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.notification_templates_template_id_seq', 1, false);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.notifications_notification_id_seq', 1, false);


--
-- Name: overtime_overtime_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.overtime_overtime_id_seq', 1, false);


--
-- Name: part_photos_photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.part_photos_photo_id_seq', 1, false);


--
-- Name: part_returns_return_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.part_returns_return_id_seq', 1, false);


--
-- Name: part_suppliers_part_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.part_suppliers_part_supplier_id_seq', 1, false);


--
-- Name: partner_current_accounts_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.partner_current_accounts_account_id_seq', 1, false);


--
-- Name: partner_transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.partner_transactions_transaction_id_seq', 1, false);


--
-- Name: partners_partner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.partners_partner_id_seq', 1, false);


--
-- Name: parts_part_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.parts_part_id_seq', 1, false);


--
-- Name: password_resets_reset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.password_resets_reset_id_seq', 1, false);


--
-- Name: payment_plan_installments_installment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.payment_plan_installments_installment_id_seq', 1, false);


--
-- Name: payment_plans_plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.payment_plans_plan_id_seq', 1, false);


--
-- Name: payment_terms_term_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.payment_terms_term_id_seq', 1, false);


--
-- Name: payments_received_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.payments_received_payment_id_seq', 1, false);


--
-- Name: permissions_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.permissions_permission_id_seq', 1, false);


--
-- Name: petty_cash_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.petty_cash_transaction_id_seq', 1, false);


--
-- Name: price_history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.price_history_history_id_seq', 1, false);


--
-- Name: price_list_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.price_list_items_item_id_seq', 1, false);


--
-- Name: price_lists_price_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.price_lists_price_list_id_seq', 1, false);


--
-- Name: promissory_notes_note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.promissory_notes_note_id_seq', 1, false);


--
-- Name: purchase_order_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.purchase_order_items_item_id_seq', 1, false);


--
-- Name: purchase_orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.purchase_orders_order_id_seq', 1, false);


--
-- Name: queue_jobs_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.queue_jobs_job_id_seq', 1, false);


--
-- Name: quotation_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.quotation_items_item_id_seq', 1, false);


--
-- Name: quotations_quotation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.quotations_quotation_id_seq', 1, false);


--
-- Name: recurring_invoices_recurring_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.recurring_invoices_recurring_invoice_id_seq', 1, false);


--
-- Name: referrals_referral_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.referrals_referral_id_seq', 1, false);


--
-- Name: reminders_reminder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.reminders_reminder_id_seq', 1, false);


--
-- Name: report_schedules_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.report_schedules_schedule_id_seq', 1, false);


--
-- Name: return_request_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.return_request_items_item_id_seq', 1, false);


--
-- Name: return_requests_return_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.return_requests_return_id_seq', 1, false);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 1, false);


--
-- Name: route_stops_stop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.route_stops_stop_id_seq', 1, false);


--
-- Name: routes_route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.routes_route_id_seq', 1, false);


--
-- Name: salaries_salary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.salaries_salary_id_seq', 1, false);


--
-- Name: saved_filters_filter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.saved_filters_filter_id_seq', 1, false);


--
-- Name: scheduled_jobs_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.scheduled_jobs_job_id_seq', 1, false);


--
-- Name: scheduled_maintenance_history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.scheduled_maintenance_history_history_id_seq', 1, false);


--
-- Name: service_area_pricing_pricing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.service_area_pricing_pricing_id_seq', 1, false);


--
-- Name: service_areas_area_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.service_areas_area_id_seq', 1, false);


--
-- Name: service_checklist_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.service_checklist_items_item_id_seq', 1, false);


--
-- Name: service_checklist_responses_response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.service_checklist_responses_response_id_seq', 1, false);


--
-- Name: service_checklist_templates_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.service_checklist_templates_template_id_seq', 1, false);


--
-- Name: service_checklists_checklist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.service_checklists_checklist_id_seq', 1, false);


--
-- Name: service_parts_service_part_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.service_parts_service_part_id_seq', 1, false);


--
-- Name: service_photos_photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.service_photos_photo_id_seq', 1, false);


--
-- Name: service_ratings_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.service_ratings_rating_id_seq', 1, false);


--
-- Name: service_zones_zone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.service_zones_zone_id_seq', 1, false);


--
-- Name: services_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.services_service_id_seq', 1, false);


--
-- Name: sgk_declarations_declaration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.sgk_declarations_declaration_id_seq', 1, false);


--
-- Name: shift_schedules_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.shift_schedules_schedule_id_seq', 1, false);


--
-- Name: shipping_methods_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.shipping_methods_method_id_seq', 1, false);


--
-- Name: sms_logs_sms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.sms_logs_sms_id_seq', 1, false);


--
-- Name: sms_templates_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.sms_templates_template_id_seq', 1, false);


--
-- Name: stock_count_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.stock_count_items_item_id_seq', 1, false);


--
-- Name: stock_counts_count_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.stock_counts_count_id_seq', 1, false);


--
-- Name: stock_movements_movement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.stock_movements_movement_id_seq', 1, false);


--
-- Name: subscriptions_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.subscriptions_subscription_id_seq', 1, false);


--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.suppliers_supplier_id_seq', 1, false);


--
-- Name: survey_answers_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.survey_answers_answer_id_seq', 1, false);


--
-- Name: survey_questions_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.survey_questions_question_id_seq', 1, false);


--
-- Name: survey_responses_response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.survey_responses_response_id_seq', 1, false);


--
-- Name: surveys_survey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.surveys_survey_id_seq', 1, false);


--
-- Name: system_settings_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.system_settings_setting_id_seq', 1, false);


--
-- Name: tags_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.tags_tag_id_seq', 1, false);


--
-- Name: tasks_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.tasks_task_id_seq', 1, false);


--
-- Name: tax_declarations_declaration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.tax_declarations_declaration_id_seq', 1, false);


--
-- Name: technician_locations_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.technician_locations_location_id_seq', 1, false);


--
-- Name: technician_performance_performance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.technician_performance_performance_id_seq', 1, false);


--
-- Name: technician_reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.technician_reviews_review_id_seq', 1, false);


--
-- Name: technician_skill_assignments_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.technician_skill_assignments_assignment_id_seq', 1, false);


--
-- Name: technician_skills_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.technician_skills_skill_id_seq', 1, false);


--
-- Name: technician_trainings_training_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.technician_trainings_training_id_seq', 1, false);


--
-- Name: technicians_technician_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.technicians_technician_id_seq', 1, false);


--
-- Name: territories_territory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.territories_territory_id_seq', 1, false);


--
-- Name: time_off_requests_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.time_off_requests_request_id_seq', 1, false);


--
-- Name: training_programs_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.training_programs_program_id_seq', 1, false);


--
-- Name: transfers_transfer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.transfers_transfer_id_seq', 1, false);


--
-- Name: two_factor_auth_tfa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.two_factor_auth_tfa_id_seq', 1, false);


--
-- Name: user_dashboard_widgets_user_widget_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.user_dashboard_widgets_user_widget_id_seq', 1, false);


--
-- Name: user_preferences_preference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.user_preferences_preference_id_seq', 1, false);


--
-- Name: user_sessions_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.user_sessions_session_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: vehicle_expenses_expense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.vehicle_expenses_expense_id_seq', 1, false);


--
-- Name: vehicle_stock_vehicle_stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.vehicle_stock_vehicle_stock_id_seq', 1, false);


--
-- Name: vehicles_vehicle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.vehicles_vehicle_id_seq', 1, false);


--
-- Name: versions_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.versions_version_id_seq', 1, false);


--
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.warehouses_warehouse_id_seq', 1, false);


--
-- Name: warranties_warranty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.warranties_warranty_id_seq', 1, false);


--
-- Name: warranty_claims_claim_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.warranty_claims_claim_id_seq', 1, false);


--
-- Name: webhook_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.webhook_logs_log_id_seq', 1, false);


--
-- Name: webhooks_webhook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.webhooks_webhook_id_seq', 1, false);


--
-- Name: work_orders_work_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.work_orders_work_order_id_seq', 1, false);


--
-- Name: workflow_steps_step_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.workflow_steps_step_id_seq', 1, false);


--
-- Name: workflows_workflow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.workflows_workflow_id_seq', 1, false);


--
-- Name: working_hours_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: akinadmin
--

SELECT pg_catalog.setval('public.working_hours_schedule_id_seq', 1, false);


--
-- Name: account_transactions account_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.account_transactions
    ADD CONSTRAINT account_transactions_pkey PRIMARY KEY (transaction_id);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (account_id);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (log_id);


--
-- Name: advance_payments advance_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.advance_payments
    ADD CONSTRAINT advance_payments_pkey PRIMARY KEY (advance_id);


--
-- Name: api_keys api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (key_id);


--
-- Name: api_rate_limits api_rate_limits_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.api_rate_limits
    ADD CONSTRAINT api_rate_limits_pkey PRIMARY KEY (limit_id);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (appointment_id);


--
-- Name: approvals approvals_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT approvals_pkey PRIMARY KEY (approval_id);


--
-- Name: assets assets_asset_code_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_asset_code_key UNIQUE (asset_code);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (asset_id);


--
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (attachment_id);


--
-- Name: attendance attendance_employee_id_attendance_date_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_employee_id_attendance_date_key UNIQUE (employee_id, attendance_date);


--
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (attendance_id);


--
-- Name: attendance attendance_technician_id_attendance_date_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_technician_id_attendance_date_key UNIQUE (technician_id, attendance_date);


--
-- Name: audit_trail audit_trail_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.audit_trail
    ADD CONSTRAINT audit_trail_pkey PRIMARY KEY (audit_id);


--
-- Name: automation_rules automation_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.automation_rules
    ADD CONSTRAINT automation_rules_pkey PRIMARY KEY (rule_id);


--
-- Name: automation_rules automation_rules_rule_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.automation_rules
    ADD CONSTRAINT automation_rules_rule_name_key UNIQUE (rule_name);


--
-- Name: backup_logs backup_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.backup_logs
    ADD CONSTRAINT backup_logs_pkey PRIMARY KEY (backup_id);


--
-- Name: bank_reconciliation_items bank_reconciliation_items_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.bank_reconciliation_items
    ADD CONSTRAINT bank_reconciliation_items_pkey PRIMARY KEY (item_id);


--
-- Name: bank_reconciliation bank_reconciliation_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.bank_reconciliation
    ADD CONSTRAINT bank_reconciliation_pkey PRIMARY KEY (reconciliation_id);


--
-- Name: bookmarks bookmarks_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT bookmarks_pkey PRIMARY KEY (bookmark_id);


--
-- Name: bookmarks bookmarks_user_id_entity_type_entity_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT bookmarks_user_id_entity_type_entity_id_key UNIQUE (user_id, entity_type, entity_id);


--
-- Name: budgets budgets_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_pkey PRIMARY KEY (budget_id);


--
-- Name: call_recordings call_recordings_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.call_recordings
    ADD CONSTRAINT call_recordings_pkey PRIMARY KEY (recording_id);


--
-- Name: calls calls_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_pkey PRIMARY KEY (call_id);


--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (campaign_id);


--
-- Name: capacity_planning capacity_planning_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.capacity_planning
    ADD CONSTRAINT capacity_planning_pkey PRIMARY KEY (date);


--
-- Name: certifications certifications_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.certifications
    ADD CONSTRAINT certifications_pkey PRIMARY KEY (certification_id);


--
-- Name: checks checks_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.checks
    ADD CONSTRAINT checks_pkey PRIMARY KEY (check_id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (comment_id);


--
-- Name: commissions commissions_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_pkey PRIMARY KEY (commission_id);


--
-- Name: communication_logs communication_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.communication_logs
    ADD CONSTRAINT communication_logs_pkey PRIMARY KEY (log_id);


--
-- Name: complaints complaints_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.complaints
    ADD CONSTRAINT complaints_pkey PRIMARY KEY (complaint_id);


--
-- Name: contract_services contract_services_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.contract_services
    ADD CONSTRAINT contract_services_pkey PRIMARY KEY (contract_service_id);


--
-- Name: contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (contract_id);


--
-- Name: coupon_usage coupon_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.coupon_usage
    ADD CONSTRAINT coupon_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: coupons coupons_coupon_code_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_coupon_code_key UNIQUE (coupon_code);


--
-- Name: coupons coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (coupon_id);


--
-- Name: credit_limits credit_limits_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_limits
    ADD CONSTRAINT credit_limits_customer_id_key UNIQUE (customer_id);


--
-- Name: credit_limits credit_limits_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_limits
    ADD CONSTRAINT credit_limits_pkey PRIMARY KEY (limit_id);


--
-- Name: credit_note_items credit_note_items_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_note_items
    ADD CONSTRAINT credit_note_items_pkey PRIMARY KEY (item_id);


--
-- Name: credit_notes credit_notes_credit_note_number_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_notes
    ADD CONSTRAINT credit_notes_credit_note_number_key UNIQUE (credit_note_number);


--
-- Name: credit_notes credit_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_notes
    ADD CONSTRAINT credit_notes_pkey PRIMARY KEY (credit_note_id);


--
-- Name: current_account_transactions current_account_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.current_account_transactions
    ADD CONSTRAINT current_account_transactions_pkey PRIMARY KEY (transaction_id);


--
-- Name: current_accounts current_accounts_account_type_entity_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.current_accounts
    ADD CONSTRAINT current_accounts_account_type_entity_id_key UNIQUE (account_type, entity_id);


--
-- Name: current_accounts current_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.current_accounts
    ADD CONSTRAINT current_accounts_pkey PRIMARY KEY (account_id);


--
-- Name: customer_addresses customer_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_addresses
    ADD CONSTRAINT customer_addresses_pkey PRIMARY KEY (address_id);


--
-- Name: customer_contacts customer_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_contacts
    ADD CONSTRAINT customer_contacts_pkey PRIMARY KEY (contact_id);


--
-- Name: customer_notes customer_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_notes
    ADD CONSTRAINT customer_notes_pkey PRIMARY KEY (note_id);


--
-- Name: customer_preferences customer_preferences_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_preferences
    ADD CONSTRAINT customer_preferences_customer_id_key UNIQUE (customer_id);


--
-- Name: customer_preferences customer_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_preferences
    ADD CONSTRAINT customer_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: dashboard_widgets dashboard_widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.dashboard_widgets
    ADD CONSTRAINT dashboard_widgets_pkey PRIMARY KEY (widget_id);


--
-- Name: data_exports data_exports_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.data_exports
    ADD CONSTRAINT data_exports_pkey PRIMARY KEY (export_id);


--
-- Name: debit_notes debit_notes_debit_note_number_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.debit_notes
    ADD CONSTRAINT debit_notes_debit_note_number_key UNIQUE (debit_note_number);


--
-- Name: debit_notes debit_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.debit_notes
    ADD CONSTRAINT debit_notes_pkey PRIMARY KEY (debit_note_id);


--
-- Name: depreciation depreciation_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.depreciation
    ADD CONSTRAINT depreciation_pkey PRIMARY KEY (depreciation_id);


--
-- Name: device_documents device_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.device_documents
    ADD CONSTRAINT device_documents_pkey PRIMARY KEY (document_id);


--
-- Name: device_history device_history_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.device_history
    ADD CONSTRAINT device_history_pkey PRIMARY KEY (history_id);


--
-- Name: device_parts device_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.device_parts
    ADD CONSTRAINT device_parts_pkey PRIMARY KEY (device_part_id);


--
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (device_id);


--
-- Name: devices devices_serial_number_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_serial_number_key UNIQUE (serial_number);


--
-- Name: discount_codes discount_codes_code_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.discount_codes
    ADD CONSTRAINT discount_codes_code_key UNIQUE (code);


--
-- Name: discount_codes discount_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.discount_codes
    ADD CONSTRAINT discount_codes_pkey PRIMARY KEY (code_id);


--
-- Name: document_photos document_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.document_photos
    ADD CONSTRAINT document_photos_pkey PRIMARY KEY (photo_id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (document_id);


--
-- Name: email_logs email_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT email_logs_pkey PRIMARY KEY (email_id);


--
-- Name: email_templates email_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT email_templates_pkey PRIMARY KEY (template_id);


--
-- Name: email_templates email_templates_template_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT email_templates_template_name_key UNIQUE (template_name);


--
-- Name: emergency_contacts emergency_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.emergency_contacts
    ADD CONSTRAINT emergency_contacts_pkey PRIMARY KEY (contact_id);


--
-- Name: employee_documents employee_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.employee_documents
    ADD CONSTRAINT employee_documents_pkey PRIMARY KEY (document_id);


--
-- Name: employee_shifts employee_shifts_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.employee_shifts
    ADD CONSTRAINT employee_shifts_pkey PRIMARY KEY (assignment_id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: entity_tags entity_tags_entity_type_entity_id_tag_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.entity_tags
    ADD CONSTRAINT entity_tags_entity_type_entity_id_tag_id_key UNIQUE (entity_type, entity_id, tag_id);


--
-- Name: entity_tags entity_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.entity_tags
    ADD CONSTRAINT entity_tags_pkey PRIMARY KEY (entity_tag_id);


--
-- Name: exchange_rates exchange_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.exchange_rates
    ADD CONSTRAINT exchange_rates_pkey PRIMARY KEY (rate_id);


--
-- Name: expense_categories expense_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.expense_categories
    ADD CONSTRAINT expense_categories_pkey PRIMARY KEY (category_id);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (expense_id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (failed_job_id);


--
-- Name: fault_codes fault_codes_code_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.fault_codes
    ADD CONSTRAINT fault_codes_code_key UNIQUE (code);


--
-- Name: fault_codes fault_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.fault_codes
    ADD CONSTRAINT fault_codes_pkey PRIMARY KEY (code_id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (file_id);


--
-- Name: holidays holidays_holiday_date_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.holidays
    ADD CONSTRAINT holidays_holiday_date_key UNIQUE (holiday_date);


--
-- Name: holidays holidays_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.holidays
    ADD CONSTRAINT holidays_pkey PRIMARY KEY (holiday_id);


--
-- Name: installment_plans installment_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.installment_plans
    ADD CONSTRAINT installment_plans_pkey PRIMARY KEY (plan_id);


--
-- Name: installments installments_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.installments
    ADD CONSTRAINT installments_pkey PRIMARY KEY (installment_id);


--
-- Name: insurance_policies insurance_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.insurance_policies
    ADD CONSTRAINT insurance_policies_pkey PRIMARY KEY (policy_id);


--
-- Name: insurance_policies insurance_policies_policy_number_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.insurance_policies
    ADD CONSTRAINT insurance_policies_policy_number_key UNIQUE (policy_number);


--
-- Name: integration_logs integration_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.integration_logs
    ADD CONSTRAINT integration_logs_pkey PRIMARY KEY (log_id);


--
-- Name: internal_messages internal_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.internal_messages
    ADD CONSTRAINT internal_messages_pkey PRIMARY KEY (message_id);


--
-- Name: inventory_adjustment_items inventory_adjustment_items_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.inventory_adjustment_items
    ADD CONSTRAINT inventory_adjustment_items_pkey PRIMARY KEY (item_id);


--
-- Name: inventory_adjustments inventory_adjustments_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.inventory_adjustments
    ADD CONSTRAINT inventory_adjustments_pkey PRIMARY KEY (adjustment_id);


--
-- Name: invoice_items invoice_items_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_pkey PRIMARY KEY (item_id);


--
-- Name: invoices invoices_invoice_number_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_invoice_number_key UNIQUE (invoice_number);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (invoice_id);


--
-- Name: ip_whitelist ip_whitelist_ip_address_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.ip_whitelist
    ADD CONSTRAINT ip_whitelist_ip_address_key UNIQUE (ip_address);


--
-- Name: ip_whitelist ip_whitelist_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.ip_whitelist
    ADD CONSTRAINT ip_whitelist_pkey PRIMARY KEY (whitelist_id);


--
-- Name: kpi_metrics kpi_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.kpi_metrics
    ADD CONSTRAINT kpi_metrics_pkey PRIMARY KEY (metric_id);


--
-- Name: leaves leaves_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT leaves_pkey PRIMARY KEY (leave_id);


--
-- Name: licenses licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (license_id);


--
-- Name: login_attempts login_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.login_attempts
    ADD CONSTRAINT login_attempts_pkey PRIMARY KEY (attempt_id);


--
-- Name: maintenance_schedules maintenance_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.maintenance_schedules
    ADD CONSTRAINT maintenance_schedules_pkey PRIMARY KEY (schedule_id);


--
-- Name: marketing_messages marketing_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.marketing_messages
    ADD CONSTRAINT marketing_messages_pkey PRIMARY KEY (message_id);


--
-- Name: migrations migrations_migration_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_migration_name_key UNIQUE (migration_name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (migration_id);


--
-- Name: notification_preferences notification_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: notification_preferences notification_preferences_user_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_user_id_key UNIQUE (user_id);


--
-- Name: notification_templates notification_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.notification_templates
    ADD CONSTRAINT notification_templates_pkey PRIMARY KEY (template_id);


--
-- Name: notification_templates notification_templates_template_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.notification_templates
    ADD CONSTRAINT notification_templates_template_name_key UNIQUE (template_name);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: overtime overtime_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.overtime
    ADD CONSTRAINT overtime_pkey PRIMARY KEY (overtime_id);


--
-- Name: part_photos part_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_photos
    ADD CONSTRAINT part_photos_pkey PRIMARY KEY (photo_id);


--
-- Name: part_returns part_returns_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_returns
    ADD CONSTRAINT part_returns_pkey PRIMARY KEY (return_id);


--
-- Name: part_suppliers part_suppliers_part_id_supplier_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_suppliers
    ADD CONSTRAINT part_suppliers_part_id_supplier_id_key UNIQUE (part_id, supplier_id);


--
-- Name: part_suppliers part_suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_suppliers
    ADD CONSTRAINT part_suppliers_pkey PRIMARY KEY (part_supplier_id);


--
-- Name: partner_current_accounts partner_current_accounts_partner_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.partner_current_accounts
    ADD CONSTRAINT partner_current_accounts_partner_id_key UNIQUE (partner_id);


--
-- Name: partner_current_accounts partner_current_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.partner_current_accounts
    ADD CONSTRAINT partner_current_accounts_pkey PRIMARY KEY (account_id);


--
-- Name: partner_transactions partner_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.partner_transactions
    ADD CONSTRAINT partner_transactions_pkey PRIMARY KEY (transaction_id);


--
-- Name: partners partners_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (partner_id);


--
-- Name: parts parts_part_code_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.parts
    ADD CONSTRAINT parts_part_code_key UNIQUE (part_code);


--
-- Name: parts parts_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.parts
    ADD CONSTRAINT parts_pkey PRIMARY KEY (part_id);


--
-- Name: password_resets password_resets_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_pkey PRIMARY KEY (reset_id);


--
-- Name: password_resets password_resets_reset_token_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_reset_token_key UNIQUE (reset_token);


--
-- Name: payment_plan_installments payment_plan_installments_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payment_plan_installments
    ADD CONSTRAINT payment_plan_installments_pkey PRIMARY KEY (installment_id);


--
-- Name: payment_plans payment_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payment_plans
    ADD CONSTRAINT payment_plans_pkey PRIMARY KEY (plan_id);


--
-- Name: payment_terms payment_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payment_terms
    ADD CONSTRAINT payment_terms_pkey PRIMARY KEY (term_id);


--
-- Name: payment_terms payment_terms_term_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payment_terms
    ADD CONSTRAINT payment_terms_term_name_key UNIQUE (term_name);


--
-- Name: payments_received payments_received_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payments_received
    ADD CONSTRAINT payments_received_pkey PRIMARY KEY (payment_id);


--
-- Name: permissions permissions_permission_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_permission_name_key UNIQUE (permission_name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (permission_id);


--
-- Name: petty_cash petty_cash_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.petty_cash
    ADD CONSTRAINT petty_cash_pkey PRIMARY KEY (transaction_id);


--
-- Name: price_history price_history_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.price_history
    ADD CONSTRAINT price_history_pkey PRIMARY KEY (history_id);


--
-- Name: price_list_items price_list_items_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.price_list_items
    ADD CONSTRAINT price_list_items_pkey PRIMARY KEY (item_id);


--
-- Name: price_lists price_lists_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.price_lists
    ADD CONSTRAINT price_lists_pkey PRIMARY KEY (price_list_id);


--
-- Name: promissory_notes promissory_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.promissory_notes
    ADD CONSTRAINT promissory_notes_pkey PRIMARY KEY (note_id);


--
-- Name: purchase_order_items purchase_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_pkey PRIMARY KEY (item_id);


--
-- Name: purchase_orders purchase_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_pkey PRIMARY KEY (order_id);


--
-- Name: queue_jobs queue_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.queue_jobs
    ADD CONSTRAINT queue_jobs_pkey PRIMARY KEY (job_id);


--
-- Name: quotation_items quotation_items_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.quotation_items
    ADD CONSTRAINT quotation_items_pkey PRIMARY KEY (item_id);


--
-- Name: quotations quotations_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_pkey PRIMARY KEY (quotation_id);


--
-- Name: quotations quotations_quotation_number_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_quotation_number_key UNIQUE (quotation_number);


--
-- Name: recurring_invoices recurring_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.recurring_invoices
    ADD CONSTRAINT recurring_invoices_pkey PRIMARY KEY (recurring_invoice_id);


--
-- Name: referrals referrals_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_pkey PRIMARY KEY (referral_id);


--
-- Name: reminders reminders_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.reminders
    ADD CONSTRAINT reminders_pkey PRIMARY KEY (reminder_id);


--
-- Name: report_schedules report_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.report_schedules
    ADD CONSTRAINT report_schedules_pkey PRIMARY KEY (schedule_id);


--
-- Name: return_request_items return_request_items_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.return_request_items
    ADD CONSTRAINT return_request_items_pkey PRIMARY KEY (item_id);


--
-- Name: return_requests return_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.return_requests
    ADD CONSTRAINT return_requests_pkey PRIMARY KEY (return_id);


--
-- Name: return_requests return_requests_return_number_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.return_requests
    ADD CONSTRAINT return_requests_return_number_key UNIQUE (return_number);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- Name: route_stops route_stops_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.route_stops
    ADD CONSTRAINT route_stops_pkey PRIMARY KEY (stop_id);


--
-- Name: routes routes_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (route_id);


--
-- Name: salaries salaries_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_pkey PRIMARY KEY (salary_id);


--
-- Name: saved_filters saved_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.saved_filters
    ADD CONSTRAINT saved_filters_pkey PRIMARY KEY (filter_id);


--
-- Name: scheduled_jobs scheduled_jobs_job_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.scheduled_jobs
    ADD CONSTRAINT scheduled_jobs_job_name_key UNIQUE (job_name);


--
-- Name: scheduled_jobs scheduled_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.scheduled_jobs
    ADD CONSTRAINT scheduled_jobs_pkey PRIMARY KEY (job_id);


--
-- Name: scheduled_maintenance_history scheduled_maintenance_history_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.scheduled_maintenance_history
    ADD CONSTRAINT scheduled_maintenance_history_pkey PRIMARY KEY (history_id);


--
-- Name: service_area_pricing service_area_pricing_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_area_pricing
    ADD CONSTRAINT service_area_pricing_pkey PRIMARY KEY (pricing_id);


--
-- Name: service_areas service_areas_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_areas
    ADD CONSTRAINT service_areas_pkey PRIMARY KEY (area_id);


--
-- Name: service_checklist_items service_checklist_items_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklist_items
    ADD CONSTRAINT service_checklist_items_pkey PRIMARY KEY (item_id);


--
-- Name: service_checklist_responses service_checklist_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklist_responses
    ADD CONSTRAINT service_checklist_responses_pkey PRIMARY KEY (response_id);


--
-- Name: service_checklist_templates service_checklist_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklist_templates
    ADD CONSTRAINT service_checklist_templates_pkey PRIMARY KEY (template_id);


--
-- Name: service_checklists service_checklists_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklists
    ADD CONSTRAINT service_checklists_pkey PRIMARY KEY (checklist_id);


--
-- Name: service_parts service_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_parts
    ADD CONSTRAINT service_parts_pkey PRIMARY KEY (service_part_id);


--
-- Name: service_photos service_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_photos
    ADD CONSTRAINT service_photos_pkey PRIMARY KEY (photo_id);


--
-- Name: service_ratings service_ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_ratings
    ADD CONSTRAINT service_ratings_pkey PRIMARY KEY (rating_id);


--
-- Name: service_ratings service_ratings_service_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_ratings
    ADD CONSTRAINT service_ratings_service_id_key UNIQUE (service_id);


--
-- Name: service_zones service_zones_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_zones
    ADD CONSTRAINT service_zones_pkey PRIMARY KEY (zone_id);


--
-- Name: service_zones service_zones_zone_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_zones
    ADD CONSTRAINT service_zones_zone_name_key UNIQUE (zone_name);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (service_id);


--
-- Name: sgk_declarations sgk_declarations_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.sgk_declarations
    ADD CONSTRAINT sgk_declarations_pkey PRIMARY KEY (declaration_id);


--
-- Name: shift_schedules shift_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.shift_schedules
    ADD CONSTRAINT shift_schedules_pkey PRIMARY KEY (schedule_id);


--
-- Name: shipping_methods shipping_methods_method_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.shipping_methods
    ADD CONSTRAINT shipping_methods_method_name_key UNIQUE (method_name);


--
-- Name: shipping_methods shipping_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.shipping_methods
    ADD CONSTRAINT shipping_methods_pkey PRIMARY KEY (method_id);


--
-- Name: sms_logs sms_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.sms_logs
    ADD CONSTRAINT sms_logs_pkey PRIMARY KEY (sms_id);


--
-- Name: sms_templates sms_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.sms_templates
    ADD CONSTRAINT sms_templates_pkey PRIMARY KEY (template_id);


--
-- Name: sms_templates sms_templates_template_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.sms_templates
    ADD CONSTRAINT sms_templates_template_name_key UNIQUE (template_name);


--
-- Name: stock_count_items stock_count_items_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_count_items
    ADD CONSTRAINT stock_count_items_pkey PRIMARY KEY (item_id);


--
-- Name: stock_counts stock_counts_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_counts
    ADD CONSTRAINT stock_counts_pkey PRIMARY KEY (count_id);


--
-- Name: stock_movements stock_movements_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_pkey PRIMARY KEY (movement_id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (subscription_id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id);


--
-- Name: survey_answers survey_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.survey_answers
    ADD CONSTRAINT survey_answers_pkey PRIMARY KEY (answer_id);


--
-- Name: survey_questions survey_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.survey_questions
    ADD CONSTRAINT survey_questions_pkey PRIMARY KEY (question_id);


--
-- Name: survey_responses survey_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT survey_responses_pkey PRIMARY KEY (response_id);


--
-- Name: surveys surveys_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.surveys
    ADD CONSTRAINT surveys_pkey PRIMARY KEY (survey_id);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (setting_id);


--
-- Name: system_settings system_settings_setting_key_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_setting_key_key UNIQUE (setting_key);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- Name: tags tags_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_tag_name_key UNIQUE (tag_name);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (task_id);


--
-- Name: tax_declarations tax_declarations_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.tax_declarations
    ADD CONSTRAINT tax_declarations_pkey PRIMARY KEY (declaration_id);


--
-- Name: technician_locations technician_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_locations
    ADD CONSTRAINT technician_locations_pkey PRIMARY KEY (location_id);


--
-- Name: technician_performance technician_performance_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_performance
    ADD CONSTRAINT technician_performance_pkey PRIMARY KEY (performance_id);


--
-- Name: technician_performance technician_performance_technician_id_period_month_period_ye_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_performance
    ADD CONSTRAINT technician_performance_technician_id_period_month_period_ye_key UNIQUE (technician_id, period_month, period_year);


--
-- Name: technician_reviews technician_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_reviews
    ADD CONSTRAINT technician_reviews_pkey PRIMARY KEY (review_id);


--
-- Name: technician_skill_assignments technician_skill_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_skill_assignments
    ADD CONSTRAINT technician_skill_assignments_pkey PRIMARY KEY (assignment_id);


--
-- Name: technician_skill_assignments technician_skill_assignments_technician_id_skill_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_skill_assignments
    ADD CONSTRAINT technician_skill_assignments_technician_id_skill_id_key UNIQUE (technician_id, skill_id);


--
-- Name: technician_skills technician_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_skills
    ADD CONSTRAINT technician_skills_pkey PRIMARY KEY (skill_id);


--
-- Name: technician_skills technician_skills_skill_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_skills
    ADD CONSTRAINT technician_skills_skill_name_key UNIQUE (skill_name);


--
-- Name: technician_trainings technician_trainings_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_trainings
    ADD CONSTRAINT technician_trainings_pkey PRIMARY KEY (training_id);


--
-- Name: technicians technicians_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technicians
    ADD CONSTRAINT technicians_pkey PRIMARY KEY (technician_id);


--
-- Name: territories territories_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.territories
    ADD CONSTRAINT territories_pkey PRIMARY KEY (territory_id);


--
-- Name: territories territories_territory_code_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.territories
    ADD CONSTRAINT territories_territory_code_key UNIQUE (territory_code);


--
-- Name: territories territories_territory_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.territories
    ADD CONSTRAINT territories_territory_name_key UNIQUE (territory_name);


--
-- Name: time_off_requests time_off_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.time_off_requests
    ADD CONSTRAINT time_off_requests_pkey PRIMARY KEY (request_id);


--
-- Name: training_programs training_programs_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.training_programs
    ADD CONSTRAINT training_programs_pkey PRIMARY KEY (program_id);


--
-- Name: transfers transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_pkey PRIMARY KEY (transfer_id);


--
-- Name: two_factor_auth two_factor_auth_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.two_factor_auth
    ADD CONSTRAINT two_factor_auth_pkey PRIMARY KEY (tfa_id);


--
-- Name: two_factor_auth two_factor_auth_user_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.two_factor_auth
    ADD CONSTRAINT two_factor_auth_user_id_key UNIQUE (user_id);


--
-- Name: user_dashboard_widgets user_dashboard_widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_dashboard_widgets
    ADD CONSTRAINT user_dashboard_widgets_pkey PRIMARY KEY (user_widget_id);


--
-- Name: user_dashboard_widgets user_dashboard_widgets_user_id_widget_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_dashboard_widgets
    ADD CONSTRAINT user_dashboard_widgets_user_id_widget_id_key UNIQUE (user_id, widget_id);


--
-- Name: user_preferences user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: user_preferences user_preferences_user_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_user_id_key UNIQUE (user_id);


--
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (session_id);


--
-- Name: user_sessions user_sessions_session_token_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_session_token_key UNIQUE (session_token);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: vehicle_expenses vehicle_expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.vehicle_expenses
    ADD CONSTRAINT vehicle_expenses_pkey PRIMARY KEY (expense_id);


--
-- Name: vehicle_stock vehicle_stock_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.vehicle_stock
    ADD CONSTRAINT vehicle_stock_pkey PRIMARY KEY (vehicle_stock_id);


--
-- Name: vehicle_stock vehicle_stock_technician_id_part_id_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.vehicle_stock
    ADD CONSTRAINT vehicle_stock_technician_id_part_id_key UNIQUE (technician_id, part_id);


--
-- Name: vehicles vehicles_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_pkey PRIMARY KEY (vehicle_id);


--
-- Name: vehicles vehicles_plate_number_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_plate_number_key UNIQUE (plate_number);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (version_id);


--
-- Name: warehouses warehouses_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (warehouse_id);


--
-- Name: warranties warranties_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.warranties
    ADD CONSTRAINT warranties_pkey PRIMARY KEY (warranty_id);


--
-- Name: warranty_claims warranty_claims_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.warranty_claims
    ADD CONSTRAINT warranty_claims_pkey PRIMARY KEY (claim_id);


--
-- Name: webhook_logs webhook_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.webhook_logs
    ADD CONSTRAINT webhook_logs_pkey PRIMARY KEY (log_id);


--
-- Name: webhooks webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.webhooks
    ADD CONSTRAINT webhooks_pkey PRIMARY KEY (webhook_id);


--
-- Name: work_orders work_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_pkey PRIMARY KEY (work_order_id);


--
-- Name: work_orders work_orders_work_order_number_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_work_order_number_key UNIQUE (work_order_number);


--
-- Name: workflow_steps workflow_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.workflow_steps
    ADD CONSTRAINT workflow_steps_pkey PRIMARY KEY (step_id);


--
-- Name: workflows workflows_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT workflows_pkey PRIMARY KEY (workflow_id);


--
-- Name: workflows workflows_workflow_name_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT workflows_workflow_name_key UNIQUE (workflow_name);


--
-- Name: working_hours working_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.working_hours
    ADD CONSTRAINT working_hours_pkey PRIMARY KEY (schedule_id);


--
-- Name: working_hours working_hours_technician_id_day_of_week_key; Type: CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.working_hours
    ADD CONSTRAINT working_hours_technician_id_day_of_week_key UNIQUE (technician_id, day_of_week);


--
-- Name: idx_activity_logs_created; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_activity_logs_created ON public.activity_logs USING btree (created_at);


--
-- Name: idx_activity_logs_entity; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_activity_logs_entity ON public.activity_logs USING btree (entity_type, entity_id);


--
-- Name: idx_activity_logs_user; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_activity_logs_user ON public.activity_logs USING btree (user_id);


--
-- Name: idx_advance_payments_entity; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_advance_payments_entity ON public.advance_payments USING btree (entity_type, entity_id);


--
-- Name: idx_appointments_date; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_appointments_date ON public.appointments USING btree (appointment_date);


--
-- Name: idx_appointments_date_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_appointments_date_status ON public.appointments USING btree (appointment_date, status);


--
-- Name: idx_appointments_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_appointments_status ON public.appointments USING btree (status);


--
-- Name: idx_appointments_technician; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_appointments_technician ON public.appointments USING btree (assigned_technician_id);


--
-- Name: idx_approvals_entity; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_approvals_entity ON public.approvals USING btree (entity_type, entity_id);


--
-- Name: idx_assets_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_assets_status ON public.assets USING btree (status);


--
-- Name: idx_attachments_entity; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_attachments_entity ON public.attachments USING btree (entity_type, entity_id);


--
-- Name: idx_attendance_employee_date; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_attendance_employee_date ON public.attendance USING btree (employee_id, attendance_date);


--
-- Name: idx_attendance_technician_date; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_attendance_technician_date ON public.attendance USING btree (technician_id, attendance_date);


--
-- Name: idx_audit_trail_created; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_audit_trail_created ON public.audit_trail USING btree (created_at);


--
-- Name: idx_audit_trail_entity; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_audit_trail_entity ON public.audit_trail USING btree (entity_type, entity_id);


--
-- Name: idx_audit_trail_user; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_audit_trail_user ON public.audit_trail USING btree (user_id);


--
-- Name: idx_calls_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_calls_customer ON public.calls USING btree (customer_id);


--
-- Name: idx_calls_date; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_calls_date ON public.calls USING btree (call_date);


--
-- Name: idx_campaigns_dates; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_campaigns_dates ON public.campaigns USING btree (start_date, end_date);


--
-- Name: idx_checks_due_date; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_checks_due_date ON public.checks USING btree (due_date);


--
-- Name: idx_checks_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_checks_status ON public.checks USING btree (status);


--
-- Name: idx_comments_entity; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_comments_entity ON public.comments USING btree (entity_type, entity_id);


--
-- Name: idx_commissions_employee; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_commissions_employee ON public.commissions USING btree (employee_id);


--
-- Name: idx_commissions_technician; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_commissions_technician ON public.commissions USING btree (technician_id);


--
-- Name: idx_communication_logs_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_communication_logs_customer ON public.communication_logs USING btree (customer_id);


--
-- Name: idx_complaints_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_complaints_customer ON public.complaints USING btree (customer_id);


--
-- Name: idx_complaints_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_complaints_status ON public.complaints USING btree (status);


--
-- Name: idx_contracts_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_contracts_customer ON public.contracts USING btree (customer_id);


--
-- Name: idx_contracts_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_contracts_status ON public.contracts USING btree (status);


--
-- Name: idx_credit_notes_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_credit_notes_customer ON public.credit_notes USING btree (customer_id);


--
-- Name: idx_credit_notes_invoice; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_credit_notes_invoice ON public.credit_notes USING btree (invoice_id);


--
-- Name: idx_current_accounts_type_entity; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_current_accounts_type_entity ON public.current_accounts USING btree (account_type, entity_id);


--
-- Name: idx_customer_addresses_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_customer_addresses_customer ON public.customer_addresses USING btree (customer_id);


--
-- Name: idx_customer_notes_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_customer_notes_customer ON public.customer_notes USING btree (customer_id);


--
-- Name: idx_customers_email; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_customers_email ON public.customers USING btree (email);


--
-- Name: idx_customers_phone; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_customers_phone ON public.customers USING btree (phone);


--
-- Name: idx_customers_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_customers_status ON public.customers USING btree (status);


--
-- Name: idx_device_parts_device; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_device_parts_device ON public.device_parts USING btree (device_id);


--
-- Name: idx_device_parts_part; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_device_parts_part ON public.device_parts USING btree (part_id);


--
-- Name: idx_devices_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_devices_customer ON public.devices USING btree (customer_id);


--
-- Name: idx_devices_serial; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_devices_serial ON public.devices USING btree (serial_number);


--
-- Name: idx_document_photos_entity; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_document_photos_entity ON public.document_photos USING btree (entity_type, entity_id);


--
-- Name: idx_employee_documents_employee; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_employee_documents_employee ON public.employee_documents USING btree (employee_id);


--
-- Name: idx_entity_tags_entity; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_entity_tags_entity ON public.entity_tags USING btree (entity_type, entity_id);


--
-- Name: idx_expenses_category; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_expenses_category ON public.expenses USING btree (expense_category_id);


--
-- Name: idx_expenses_date; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_expenses_date ON public.expenses USING btree (expense_date);


--
-- Name: idx_expenses_date_category; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_expenses_date_category ON public.expenses USING btree (expense_date, expense_category_id);


--
-- Name: idx_expenses_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_expenses_status ON public.expenses USING btree (approval_status);


--
-- Name: idx_fault_codes_code; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_fault_codes_code ON public.fault_codes USING btree (code);


--
-- Name: idx_files_created; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_files_created ON public.files USING btree (created_at);


--
-- Name: idx_files_entity; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_files_entity ON public.files USING btree (entity_type, entity_id);


--
-- Name: idx_insurance_expiry; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_insurance_expiry ON public.insurance_policies USING btree (end_date);


--
-- Name: idx_invoices_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_invoices_customer ON public.invoices USING btree (customer_id);


--
-- Name: idx_invoices_customer_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_invoices_customer_status ON public.invoices USING btree (customer_id, payment_status);


--
-- Name: idx_invoices_date; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_invoices_date ON public.invoices USING btree (invoice_date);


--
-- Name: idx_invoices_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_invoices_status ON public.invoices USING btree (payment_status);


--
-- Name: idx_leaves_employee; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_leaves_employee ON public.leaves USING btree (employee_id);


--
-- Name: idx_leaves_technician; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_leaves_technician ON public.leaves USING btree (technician_id);


--
-- Name: idx_licenses_expiry; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_licenses_expiry ON public.licenses USING btree (expiry_date);


--
-- Name: idx_login_attempts_ip; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_login_attempts_ip ON public.login_attempts USING btree (ip_address);


--
-- Name: idx_login_attempts_time; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_login_attempts_time ON public.login_attempts USING btree (attempted_at);


--
-- Name: idx_maintenance_schedules_device; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_maintenance_schedules_device ON public.maintenance_schedules USING btree (device_id);


--
-- Name: idx_notifications_user; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_notifications_user ON public.notifications USING btree (user_id);


--
-- Name: idx_overtime_employee; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_overtime_employee ON public.overtime USING btree (employee_id);


--
-- Name: idx_part_photos_part; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_part_photos_part ON public.part_photos USING btree (part_id);


--
-- Name: idx_part_returns_service_part; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_part_returns_service_part ON public.part_returns USING btree (service_part_id);


--
-- Name: idx_part_suppliers_part; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_part_suppliers_part ON public.part_suppliers USING btree (part_id);


--
-- Name: idx_part_suppliers_supplier; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_part_suppliers_supplier ON public.part_suppliers USING btree (supplier_id);


--
-- Name: idx_parts_barcode; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_parts_barcode ON public.parts USING btree (barcode);


--
-- Name: idx_parts_code; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_parts_code ON public.parts USING btree (part_code);


--
-- Name: idx_parts_sku; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_parts_sku ON public.parts USING btree (sku);


--
-- Name: idx_parts_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_parts_status ON public.parts USING btree (status);


--
-- Name: idx_parts_supplier; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_parts_supplier ON public.parts USING btree (supplier_id);


--
-- Name: idx_payment_plans_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_payment_plans_customer ON public.payment_plans USING btree (customer_id);


--
-- Name: idx_payment_plans_service; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_payment_plans_service ON public.payment_plans USING btree (service_id);


--
-- Name: idx_payments_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_payments_customer ON public.payments_received USING btree (customer_id);


--
-- Name: idx_payments_date; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_payments_date ON public.payments_received USING btree (payment_date);


--
-- Name: idx_queue_jobs_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_queue_jobs_status ON public.queue_jobs USING btree (status);


--
-- Name: idx_quotations_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_quotations_customer ON public.quotations USING btree (customer_id);


--
-- Name: idx_quotations_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_quotations_status ON public.quotations USING btree (status);


--
-- Name: idx_return_requests_customer; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_return_requests_customer ON public.return_requests USING btree (customer_id);


--
-- Name: idx_routes_technician_date; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_routes_technician_date ON public.routes USING btree (technician_id, route_date);


--
-- Name: idx_service_photos_service; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_service_photos_service ON public.service_photos USING btree (service_id);


--
-- Name: idx_service_photos_type; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_service_photos_type ON public.service_photos USING btree (photo_type);


--
-- Name: idx_service_ratings_service; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_service_ratings_service ON public.service_ratings USING btree (service_id);


--
-- Name: idx_service_zones_active; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_service_zones_active ON public.service_zones USING btree (is_active);


--
-- Name: idx_services_customer_date; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_services_customer_date ON public.services USING btree (customer_id, service_date);


--
-- Name: idx_services_date; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_services_date ON public.services USING btree (service_date);


--
-- Name: idx_services_device_date; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_services_device_date ON public.services USING btree (device_id, service_date);


--
-- Name: idx_services_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_services_status ON public.services USING btree (status);


--
-- Name: idx_services_technician; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_services_technician ON public.services USING btree (technician_id);


--
-- Name: idx_stock_movements_part; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_stock_movements_part ON public.stock_movements USING btree (part_id);


--
-- Name: idx_stock_movements_warehouse; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_stock_movements_warehouse ON public.stock_movements USING btree (warehouse_id);


--
-- Name: idx_tasks_assigned; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_tasks_assigned ON public.tasks USING btree (assigned_to);


--
-- Name: idx_tasks_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_tasks_status ON public.tasks USING btree (status);


--
-- Name: idx_technician_locations_tech_time; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_technician_locations_tech_time ON public.technician_locations USING btree (technician_id, "timestamp");


--
-- Name: idx_technician_reviews_technician; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_technician_reviews_technician ON public.technician_reviews USING btree (technician_id);


--
-- Name: idx_technicians_employee_number; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_technicians_employee_number ON public.technicians USING btree (employee_number);


--
-- Name: idx_technicians_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_technicians_status ON public.technicians USING btree (status);


--
-- Name: idx_user_sessions_token; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_user_sessions_token ON public.user_sessions USING btree (session_token);


--
-- Name: idx_user_sessions_user; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_user_sessions_user ON public.user_sessions USING btree (user_id);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: idx_users_status; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_users_status ON public.users USING btree (status);


--
-- Name: idx_versions_entity; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_versions_entity ON public.versions USING btree (entity_type, entity_id);


--
-- Name: idx_warranties_dates; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_warranties_dates ON public.warranties USING btree (start_date, end_date);


--
-- Name: idx_warranties_entity; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_warranties_entity ON public.warranties USING btree (entity_type, entity_id);


--
-- Name: idx_webhook_logs_webhook; Type: INDEX; Schema: public; Owner: akinadmin
--

CREATE INDEX idx_webhook_logs_webhook ON public.webhook_logs USING btree (webhook_id);


--
-- Name: account_transactions account_transactions_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.account_transactions
    ADD CONSTRAINT account_transactions_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- Name: account_transactions account_transactions_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.account_transactions
    ADD CONSTRAINT account_transactions_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: activity_logs activity_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: advance_payments advance_payments_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.advance_payments
    ADD CONSTRAINT advance_payments_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- Name: advance_payments advance_payments_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.advance_payments
    ADD CONSTRAINT advance_payments_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: api_rate_limits api_rate_limits_api_key_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.api_rate_limits
    ADD CONSTRAINT api_rate_limits_api_key_id_fkey FOREIGN KEY (api_key_id) REFERENCES public.api_keys(key_id);


--
-- Name: appointments appointments_assigned_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_assigned_technician_id_fkey FOREIGN KEY (assigned_technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: appointments appointments_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: appointments appointments_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE CASCADE;


--
-- Name: appointments appointments_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(device_id) ON DELETE CASCADE;


--
-- Name: approvals approvals_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT approvals_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.users(user_id);


--
-- Name: approvals approvals_requested_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT approvals_requested_by_fkey FOREIGN KEY (requested_by) REFERENCES public.users(user_id);


--
-- Name: assets assets_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.employees(employee_id);


--
-- Name: attachments attachments_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(file_id);


--
-- Name: attachments attachments_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES public.users(user_id);


--
-- Name: attendance attendance_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: attendance attendance_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: audit_trail audit_trail_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.audit_trail
    ADD CONSTRAINT audit_trail_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: bank_reconciliation bank_reconciliation_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.bank_reconciliation
    ADD CONSTRAINT bank_reconciliation_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- Name: bank_reconciliation_items bank_reconciliation_items_reconciliation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.bank_reconciliation_items
    ADD CONSTRAINT bank_reconciliation_items_reconciliation_id_fkey FOREIGN KEY (reconciliation_id) REFERENCES public.bank_reconciliation(reconciliation_id) ON DELETE CASCADE;


--
-- Name: bank_reconciliation_items bank_reconciliation_items_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.bank_reconciliation_items
    ADD CONSTRAINT bank_reconciliation_items_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES public.account_transactions(transaction_id);


--
-- Name: bank_reconciliation bank_reconciliation_reconciled_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.bank_reconciliation
    ADD CONSTRAINT bank_reconciliation_reconciled_by_fkey FOREIGN KEY (reconciled_by) REFERENCES public.users(user_id);


--
-- Name: bookmarks bookmarks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT bookmarks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: budgets budgets_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.expense_categories(category_id);


--
-- Name: call_recordings call_recordings_call_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.call_recordings
    ADD CONSTRAINT call_recordings_call_id_fkey FOREIGN KEY (call_id) REFERENCES public.calls(call_id) ON DELETE CASCADE;


--
-- Name: calls calls_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: calls calls_handled_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_handled_by_fkey FOREIGN KEY (handled_by) REFERENCES public.users(user_id);


--
-- Name: certifications certifications_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.certifications
    ADD CONSTRAINT certifications_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: checks checks_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.checks
    ADD CONSTRAINT checks_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: checks checks_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.checks
    ADD CONSTRAINT checks_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id);


--
-- Name: comments comments_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: comments comments_parent_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_parent_comment_id_fkey FOREIGN KEY (parent_comment_id) REFERENCES public.comments(comment_id);


--
-- Name: commissions commissions_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: commissions commissions_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: communication_logs communication_logs_contacted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.communication_logs
    ADD CONSTRAINT communication_logs_contacted_by_fkey FOREIGN KEY (contacted_by) REFERENCES public.users(user_id);


--
-- Name: communication_logs communication_logs_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.communication_logs
    ADD CONSTRAINT communication_logs_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: complaints complaints_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.complaints
    ADD CONSTRAINT complaints_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.users(user_id);


--
-- Name: complaints complaints_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.complaints
    ADD CONSTRAINT complaints_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: complaints complaints_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.complaints
    ADD CONSTRAINT complaints_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- Name: contract_services contract_services_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.contract_services
    ADD CONSTRAINT contract_services_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES public.contracts(contract_id) ON DELETE CASCADE;


--
-- Name: contract_services contract_services_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.contract_services
    ADD CONSTRAINT contract_services_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- Name: contracts contracts_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: contracts contracts_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(device_id);


--
-- Name: coupon_usage coupon_usage_coupon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.coupon_usage
    ADD CONSTRAINT coupon_usage_coupon_id_fkey FOREIGN KEY (coupon_id) REFERENCES public.coupons(coupon_id);


--
-- Name: coupon_usage coupon_usage_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.coupon_usage
    ADD CONSTRAINT coupon_usage_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: coupon_usage coupon_usage_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.coupon_usage
    ADD CONSTRAINT coupon_usage_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(invoice_id);


--
-- Name: credit_limits credit_limits_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_limits
    ADD CONSTRAINT credit_limits_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: credit_note_items credit_note_items_credit_note_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_note_items
    ADD CONSTRAINT credit_note_items_credit_note_id_fkey FOREIGN KEY (credit_note_id) REFERENCES public.credit_notes(credit_note_id) ON DELETE CASCADE;


--
-- Name: credit_notes credit_notes_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_notes
    ADD CONSTRAINT credit_notes_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: credit_notes credit_notes_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_notes
    ADD CONSTRAINT credit_notes_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: credit_notes credit_notes_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.credit_notes
    ADD CONSTRAINT credit_notes_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(invoice_id);


--
-- Name: current_account_transactions current_account_transactions_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.current_account_transactions
    ADD CONSTRAINT current_account_transactions_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.current_accounts(account_id);


--
-- Name: customer_addresses customer_addresses_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_addresses
    ADD CONSTRAINT customer_addresses_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE CASCADE;


--
-- Name: customer_contacts customer_contacts_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_contacts
    ADD CONSTRAINT customer_contacts_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE CASCADE;


--
-- Name: customer_notes customer_notes_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_notes
    ADD CONSTRAINT customer_notes_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: customer_notes customer_notes_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_notes
    ADD CONSTRAINT customer_notes_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE CASCADE;


--
-- Name: customer_preferences customer_preferences_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customer_preferences
    ADD CONSTRAINT customer_preferences_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE CASCADE;


--
-- Name: customers customers_assigned_sales_rep_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_assigned_sales_rep_fkey FOREIGN KEY (assigned_sales_rep) REFERENCES public.users(user_id);


--
-- Name: data_exports data_exports_requested_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.data_exports
    ADD CONSTRAINT data_exports_requested_by_fkey FOREIGN KEY (requested_by) REFERENCES public.users(user_id);


--
-- Name: debit_notes debit_notes_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.debit_notes
    ADD CONSTRAINT debit_notes_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: debit_notes debit_notes_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.debit_notes
    ADD CONSTRAINT debit_notes_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: debit_notes debit_notes_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.debit_notes
    ADD CONSTRAINT debit_notes_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(invoice_id);


--
-- Name: depreciation depreciation_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.depreciation
    ADD CONSTRAINT depreciation_asset_id_fkey FOREIGN KEY (asset_id) REFERENCES public.assets(asset_id) ON DELETE CASCADE;


--
-- Name: device_documents device_documents_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.device_documents
    ADD CONSTRAINT device_documents_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(device_id) ON DELETE CASCADE;


--
-- Name: device_documents device_documents_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.device_documents
    ADD CONSTRAINT device_documents_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(file_id);


--
-- Name: device_history device_history_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.device_history
    ADD CONSTRAINT device_history_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(device_id) ON DELETE CASCADE;


--
-- Name: device_parts device_parts_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.device_parts
    ADD CONSTRAINT device_parts_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(device_id) ON DELETE CASCADE;


--
-- Name: device_parts device_parts_installed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.device_parts
    ADD CONSTRAINT device_parts_installed_by_fkey FOREIGN KEY (installed_by) REFERENCES public.technicians(technician_id);


--
-- Name: device_parts device_parts_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.device_parts
    ADD CONSTRAINT device_parts_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(part_id);


--
-- Name: devices devices_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE CASCADE;


--
-- Name: discount_codes discount_codes_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.discount_codes
    ADD CONSTRAINT discount_codes_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES public.campaigns(campaign_id);


--
-- Name: document_photos document_photos_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.document_photos
    ADD CONSTRAINT document_photos_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(file_id);


--
-- Name: document_photos document_photos_scanned_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.document_photos
    ADD CONSTRAINT document_photos_scanned_by_fkey FOREIGN KEY (scanned_by) REFERENCES public.users(user_id);


--
-- Name: documents documents_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(file_id);


--
-- Name: emergency_contacts emergency_contacts_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.emergency_contacts
    ADD CONSTRAINT emergency_contacts_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: emergency_contacts emergency_contacts_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.emergency_contacts
    ADD CONSTRAINT emergency_contacts_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: employee_documents employee_documents_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.employee_documents
    ADD CONSTRAINT employee_documents_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE CASCADE;


--
-- Name: employee_documents employee_documents_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.employee_documents
    ADD CONSTRAINT employee_documents_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(file_id);


--
-- Name: employee_shifts employee_shifts_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.employee_shifts
    ADD CONSTRAINT employee_shifts_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: employee_shifts employee_shifts_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.employee_shifts
    ADD CONSTRAINT employee_shifts_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.shift_schedules(schedule_id);


--
-- Name: employee_shifts employee_shifts_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.employee_shifts
    ADD CONSTRAINT employee_shifts_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: employees employees_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: entity_tags entity_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.entity_tags
    ADD CONSTRAINT entity_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(tag_id) ON DELETE CASCADE;


--
-- Name: expense_categories expense_categories_parent_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.expense_categories
    ADD CONSTRAINT expense_categories_parent_category_id_fkey FOREIGN KEY (parent_category_id) REFERENCES public.expense_categories(category_id);


--
-- Name: expenses expenses_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- Name: expenses expenses_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.users(user_id);


--
-- Name: expenses expenses_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: expenses expenses_expense_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_expense_category_id_fkey FOREIGN KEY (expense_category_id) REFERENCES public.expense_categories(category_id);


--
-- Name: expenses expenses_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id);


--
-- Name: files files_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES public.users(user_id);


--
-- Name: vehicles fk_vehicle_technician; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT fk_vehicle_technician FOREIGN KEY (assigned_technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: installment_plans installment_plans_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.installment_plans
    ADD CONSTRAINT installment_plans_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(invoice_id) ON DELETE CASCADE;


--
-- Name: installments installments_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.installments
    ADD CONSTRAINT installments_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.installment_plans(plan_id) ON DELETE CASCADE;


--
-- Name: insurance_policies insurance_policies_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.insurance_policies
    ADD CONSTRAINT insurance_policies_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(file_id);


--
-- Name: internal_messages internal_messages_parent_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.internal_messages
    ADD CONSTRAINT internal_messages_parent_message_id_fkey FOREIGN KEY (parent_message_id) REFERENCES public.internal_messages(message_id);


--
-- Name: internal_messages internal_messages_recipient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.internal_messages
    ADD CONSTRAINT internal_messages_recipient_id_fkey FOREIGN KEY (recipient_id) REFERENCES public.users(user_id);


--
-- Name: internal_messages internal_messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.internal_messages
    ADD CONSTRAINT internal_messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(user_id);


--
-- Name: inventory_adjustment_items inventory_adjustment_items_adjustment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.inventory_adjustment_items
    ADD CONSTRAINT inventory_adjustment_items_adjustment_id_fkey FOREIGN KEY (adjustment_id) REFERENCES public.inventory_adjustments(adjustment_id) ON DELETE CASCADE;


--
-- Name: inventory_adjustment_items inventory_adjustment_items_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.inventory_adjustment_items
    ADD CONSTRAINT inventory_adjustment_items_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(part_id);


--
-- Name: inventory_adjustment_items inventory_adjustment_items_warehouse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.inventory_adjustment_items
    ADD CONSTRAINT inventory_adjustment_items_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES public.warehouses(warehouse_id);


--
-- Name: inventory_adjustments inventory_adjustments_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.inventory_adjustments
    ADD CONSTRAINT inventory_adjustments_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.users(user_id);


--
-- Name: inventory_adjustments inventory_adjustments_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.inventory_adjustments
    ADD CONSTRAINT inventory_adjustments_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: invoice_items invoice_items_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(invoice_id) ON DELETE CASCADE;


--
-- Name: invoices invoices_bank_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_bank_account_id_fkey FOREIGN KEY (bank_account_id) REFERENCES public.accounts(account_id);


--
-- Name: invoices invoices_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: invoices invoices_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- Name: ip_whitelist ip_whitelist_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.ip_whitelist
    ADD CONSTRAINT ip_whitelist_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: leaves leaves_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT leaves_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.users(user_id);


--
-- Name: leaves leaves_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT leaves_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: leaves leaves_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT leaves_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: licenses licenses_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(file_id);


--
-- Name: maintenance_schedules maintenance_schedules_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.maintenance_schedules
    ADD CONSTRAINT maintenance_schedules_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(device_id);


--
-- Name: marketing_messages marketing_messages_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.marketing_messages
    ADD CONSTRAINT marketing_messages_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES public.campaigns(campaign_id);


--
-- Name: notification_preferences notification_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: overtime overtime_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.overtime
    ADD CONSTRAINT overtime_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.users(user_id);


--
-- Name: overtime overtime_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.overtime
    ADD CONSTRAINT overtime_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: overtime overtime_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.overtime
    ADD CONSTRAINT overtime_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: part_photos part_photos_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_photos
    ADD CONSTRAINT part_photos_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(file_id);


--
-- Name: part_photos part_photos_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_photos
    ADD CONSTRAINT part_photos_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(part_id) ON DELETE CASCADE;


--
-- Name: part_returns part_returns_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_returns
    ADD CONSTRAINT part_returns_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: part_returns part_returns_service_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_returns
    ADD CONSTRAINT part_returns_service_part_id_fkey FOREIGN KEY (service_part_id) REFERENCES public.service_parts(service_part_id);


--
-- Name: part_suppliers part_suppliers_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_suppliers
    ADD CONSTRAINT part_suppliers_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(part_id);


--
-- Name: part_suppliers part_suppliers_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.part_suppliers
    ADD CONSTRAINT part_suppliers_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id);


--
-- Name: partner_current_accounts partner_current_accounts_partner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.partner_current_accounts
    ADD CONSTRAINT partner_current_accounts_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES public.partners(partner_id);


--
-- Name: partner_transactions partner_transactions_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.partner_transactions
    ADD CONSTRAINT partner_transactions_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- Name: partner_transactions partner_transactions_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.partner_transactions
    ADD CONSTRAINT partner_transactions_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.users(user_id);


--
-- Name: partner_transactions partner_transactions_partner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.partner_transactions
    ADD CONSTRAINT partner_transactions_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES public.partners(partner_id);


--
-- Name: parts parts_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.parts
    ADD CONSTRAINT parts_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id);


--
-- Name: password_resets password_resets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: payment_plan_installments payment_plan_installments_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payment_plan_installments
    ADD CONSTRAINT payment_plan_installments_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.payment_plans(plan_id) ON DELETE CASCADE;


--
-- Name: payment_plans payment_plans_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payment_plans
    ADD CONSTRAINT payment_plans_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: payment_plans payment_plans_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payment_plans
    ADD CONSTRAINT payment_plans_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- Name: payments_received payments_received_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payments_received
    ADD CONSTRAINT payments_received_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- Name: payments_received payments_received_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payments_received
    ADD CONSTRAINT payments_received_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: payments_received payments_received_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payments_received
    ADD CONSTRAINT payments_received_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: payments_received payments_received_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.payments_received
    ADD CONSTRAINT payments_received_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(invoice_id);


--
-- Name: petty_cash petty_cash_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.petty_cash
    ADD CONSTRAINT petty_cash_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.users(user_id);


--
-- Name: petty_cash petty_cash_handled_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.petty_cash
    ADD CONSTRAINT petty_cash_handled_by_fkey FOREIGN KEY (handled_by) REFERENCES public.users(user_id);


--
-- Name: price_history price_history_changed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.price_history
    ADD CONSTRAINT price_history_changed_by_fkey FOREIGN KEY (changed_by) REFERENCES public.users(user_id);


--
-- Name: price_history price_history_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.price_history
    ADD CONSTRAINT price_history_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(part_id);


--
-- Name: price_list_items price_list_items_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.price_list_items
    ADD CONSTRAINT price_list_items_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(part_id);


--
-- Name: price_list_items price_list_items_price_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.price_list_items
    ADD CONSTRAINT price_list_items_price_list_id_fkey FOREIGN KEY (price_list_id) REFERENCES public.price_lists(price_list_id) ON DELETE CASCADE;


--
-- Name: promissory_notes promissory_notes_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.promissory_notes
    ADD CONSTRAINT promissory_notes_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: promissory_notes promissory_notes_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.promissory_notes
    ADD CONSTRAINT promissory_notes_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id);


--
-- Name: purchase_order_items purchase_order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.purchase_orders(order_id) ON DELETE CASCADE;


--
-- Name: purchase_order_items purchase_order_items_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(part_id);


--
-- Name: purchase_orders purchase_orders_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: purchase_orders purchase_orders_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id);


--
-- Name: quotation_items quotation_items_quotation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.quotation_items
    ADD CONSTRAINT quotation_items_quotation_id_fkey FOREIGN KEY (quotation_id) REFERENCES public.quotations(quotation_id) ON DELETE CASCADE;


--
-- Name: quotations quotations_converted_to_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_converted_to_invoice_id_fkey FOREIGN KEY (converted_to_invoice_id) REFERENCES public.invoices(invoice_id);


--
-- Name: quotations quotations_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: quotations quotations_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: quotations quotations_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(device_id);


--
-- Name: recurring_invoices recurring_invoices_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.recurring_invoices
    ADD CONSTRAINT recurring_invoices_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES public.contracts(contract_id);


--
-- Name: recurring_invoices recurring_invoices_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.recurring_invoices
    ADD CONSTRAINT recurring_invoices_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: referrals referrals_referred_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_referred_customer_id_fkey FOREIGN KEY (referred_customer_id) REFERENCES public.customers(customer_id);


--
-- Name: referrals referrals_referrer_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_referrer_customer_id_fkey FOREIGN KEY (referrer_customer_id) REFERENCES public.customers(customer_id);


--
-- Name: report_schedules report_schedules_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.report_schedules
    ADD CONSTRAINT report_schedules_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: return_request_items return_request_items_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.return_request_items
    ADD CONSTRAINT return_request_items_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(part_id);


--
-- Name: return_request_items return_request_items_return_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.return_request_items
    ADD CONSTRAINT return_request_items_return_id_fkey FOREIGN KEY (return_id) REFERENCES public.return_requests(return_id) ON DELETE CASCADE;


--
-- Name: return_requests return_requests_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.return_requests
    ADD CONSTRAINT return_requests_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.users(user_id);


--
-- Name: return_requests return_requests_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.return_requests
    ADD CONSTRAINT return_requests_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: return_requests return_requests_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.return_requests
    ADD CONSTRAINT return_requests_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(invoice_id);


--
-- Name: role_permissions role_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.permissions(permission_id) ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id) ON DELETE CASCADE;


--
-- Name: route_stops route_stops_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.route_stops
    ADD CONSTRAINT route_stops_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointments(appointment_id);


--
-- Name: route_stops route_stops_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.route_stops
    ADD CONSTRAINT route_stops_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.routes(route_id) ON DELETE CASCADE;


--
-- Name: routes routes_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: salaries salaries_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- Name: salaries salaries_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: saved_filters saved_filters_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.saved_filters
    ADD CONSTRAINT saved_filters_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: scheduled_maintenance_history scheduled_maintenance_history_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.scheduled_maintenance_history
    ADD CONSTRAINT scheduled_maintenance_history_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointments(appointment_id);


--
-- Name: scheduled_maintenance_history scheduled_maintenance_history_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.scheduled_maintenance_history
    ADD CONSTRAINT scheduled_maintenance_history_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.maintenance_schedules(schedule_id);


--
-- Name: service_area_pricing service_area_pricing_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_area_pricing
    ADD CONSTRAINT service_area_pricing_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.service_areas(area_id);


--
-- Name: service_areas service_areas_assigned_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_areas
    ADD CONSTRAINT service_areas_assigned_technician_id_fkey FOREIGN KEY (assigned_technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: service_checklist_items service_checklist_items_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklist_items
    ADD CONSTRAINT service_checklist_items_template_id_fkey FOREIGN KEY (template_id) REFERENCES public.service_checklist_templates(template_id) ON DELETE CASCADE;


--
-- Name: service_checklist_responses service_checklist_responses_checklist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklist_responses
    ADD CONSTRAINT service_checklist_responses_checklist_id_fkey FOREIGN KEY (checklist_id) REFERENCES public.service_checklists(checklist_id) ON DELETE CASCADE;


--
-- Name: service_checklist_responses service_checklist_responses_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklist_responses
    ADD CONSTRAINT service_checklist_responses_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.service_checklist_items(item_id);


--
-- Name: service_checklists service_checklists_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklists
    ADD CONSTRAINT service_checklists_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id) ON DELETE CASCADE;


--
-- Name: service_checklists service_checklists_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_checklists
    ADD CONSTRAINT service_checklists_template_id_fkey FOREIGN KEY (template_id) REFERENCES public.service_checklist_templates(template_id);


--
-- Name: service_parts service_parts_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_parts
    ADD CONSTRAINT service_parts_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(part_id);


--
-- Name: service_parts service_parts_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_parts
    ADD CONSTRAINT service_parts_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id) ON DELETE CASCADE;


--
-- Name: service_photos service_photos_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_photos
    ADD CONSTRAINT service_photos_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(file_id);


--
-- Name: service_photos service_photos_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_photos
    ADD CONSTRAINT service_photos_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id) ON DELETE CASCADE;


--
-- Name: service_photos service_photos_taken_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_photos
    ADD CONSTRAINT service_photos_taken_by_fkey FOREIGN KEY (taken_by) REFERENCES public.technicians(technician_id);


--
-- Name: service_ratings service_ratings_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_ratings
    ADD CONSTRAINT service_ratings_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- Name: service_zones service_zones_default_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.service_zones
    ADD CONSTRAINT service_zones_default_technician_id_fkey FOREIGN KEY (default_technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: services services_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointments(appointment_id);


--
-- Name: services services_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON DELETE CASCADE;


--
-- Name: services services_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(device_id) ON DELETE CASCADE;


--
-- Name: services services_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.invoices(invoice_id);


--
-- Name: services services_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: stock_count_items stock_count_items_count_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_count_items
    ADD CONSTRAINT stock_count_items_count_id_fkey FOREIGN KEY (count_id) REFERENCES public.stock_counts(count_id) ON DELETE CASCADE;


--
-- Name: stock_count_items stock_count_items_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_count_items
    ADD CONSTRAINT stock_count_items_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(part_id);


--
-- Name: stock_counts stock_counts_counted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_counts
    ADD CONSTRAINT stock_counts_counted_by_fkey FOREIGN KEY (counted_by) REFERENCES public.users(user_id);


--
-- Name: stock_counts stock_counts_warehouse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_counts
    ADD CONSTRAINT stock_counts_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES public.warehouses(warehouse_id);


--
-- Name: stock_movements stock_movements_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: stock_movements stock_movements_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(part_id);


--
-- Name: stock_movements stock_movements_warehouse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES public.warehouses(warehouse_id);


--
-- Name: survey_answers survey_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.survey_answers
    ADD CONSTRAINT survey_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.survey_questions(question_id);


--
-- Name: survey_answers survey_answers_response_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.survey_answers
    ADD CONSTRAINT survey_answers_response_id_fkey FOREIGN KEY (response_id) REFERENCES public.survey_responses(response_id) ON DELETE CASCADE;


--
-- Name: survey_questions survey_questions_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.survey_questions
    ADD CONSTRAINT survey_questions_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.surveys(survey_id) ON DELETE CASCADE;


--
-- Name: survey_responses survey_responses_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT survey_responses_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: survey_responses survey_responses_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT survey_responses_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- Name: survey_responses survey_responses_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT survey_responses_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES public.surveys(survey_id);


--
-- Name: system_settings system_settings_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(user_id);


--
-- Name: tasks tasks_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.users(user_id);


--
-- Name: tasks tasks_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: technician_locations technician_locations_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_locations
    ADD CONSTRAINT technician_locations_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: technician_performance technician_performance_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_performance
    ADD CONSTRAINT technician_performance_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: technician_reviews technician_reviews_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_reviews
    ADD CONSTRAINT technician_reviews_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: technician_reviews technician_reviews_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_reviews
    ADD CONSTRAINT technician_reviews_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- Name: technician_reviews technician_reviews_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_reviews
    ADD CONSTRAINT technician_reviews_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: technician_skill_assignments technician_skill_assignments_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_skill_assignments
    ADD CONSTRAINT technician_skill_assignments_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.technician_skills(skill_id);


--
-- Name: technician_skill_assignments technician_skill_assignments_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_skill_assignments
    ADD CONSTRAINT technician_skill_assignments_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: technician_trainings technician_trainings_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_trainings
    ADD CONSTRAINT technician_trainings_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.training_programs(program_id);


--
-- Name: technician_trainings technician_trainings_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technician_trainings
    ADD CONSTRAINT technician_trainings_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: technicians technicians_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technicians
    ADD CONSTRAINT technicians_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: technicians technicians_vehicle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.technicians
    ADD CONSTRAINT technicians_vehicle_id_fkey FOREIGN KEY (vehicle_id) REFERENCES public.vehicles(vehicle_id);


--
-- Name: territories territories_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.territories
    ADD CONSTRAINT territories_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.users(user_id);


--
-- Name: territories territories_parent_territory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.territories
    ADD CONSTRAINT territories_parent_territory_id_fkey FOREIGN KEY (parent_territory_id) REFERENCES public.territories(territory_id);


--
-- Name: time_off_requests time_off_requests_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.time_off_requests
    ADD CONSTRAINT time_off_requests_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.users(user_id);


--
-- Name: time_off_requests time_off_requests_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.time_off_requests
    ADD CONSTRAINT time_off_requests_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: transfers transfers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: transfers transfers_from_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_from_account_id_fkey FOREIGN KEY (from_account_id) REFERENCES public.accounts(account_id);


--
-- Name: transfers transfers_to_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_to_account_id_fkey FOREIGN KEY (to_account_id) REFERENCES public.accounts(account_id);


--
-- Name: two_factor_auth two_factor_auth_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.two_factor_auth
    ADD CONSTRAINT two_factor_auth_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_dashboard_widgets user_dashboard_widgets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_dashboard_widgets
    ADD CONSTRAINT user_dashboard_widgets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_dashboard_widgets user_dashboard_widgets_widget_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_dashboard_widgets
    ADD CONSTRAINT user_dashboard_widgets_widget_id_fkey FOREIGN KEY (widget_id) REFERENCES public.dashboard_widgets(widget_id);


--
-- Name: user_preferences user_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_sessions user_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- Name: vehicle_expenses vehicle_expenses_vehicle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.vehicle_expenses
    ADD CONSTRAINT vehicle_expenses_vehicle_id_fkey FOREIGN KEY (vehicle_id) REFERENCES public.vehicles(vehicle_id);


--
-- Name: vehicle_stock vehicle_stock_part_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.vehicle_stock
    ADD CONSTRAINT vehicle_stock_part_id_fkey FOREIGN KEY (part_id) REFERENCES public.parts(part_id);


--
-- Name: vehicle_stock vehicle_stock_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.vehicle_stock
    ADD CONSTRAINT vehicle_stock_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: versions versions_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: warranty_claims warranty_claims_warranty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.warranty_claims
    ADD CONSTRAINT warranty_claims_warranty_id_fkey FOREIGN KEY (warranty_id) REFERENCES public.warranties(warranty_id);


--
-- Name: webhook_logs webhook_logs_webhook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.webhook_logs
    ADD CONSTRAINT webhook_logs_webhook_id_fkey FOREIGN KEY (webhook_id) REFERENCES public.webhooks(webhook_id);


--
-- Name: work_orders work_orders_assigned_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_assigned_technician_id_fkey FOREIGN KEY (assigned_technician_id) REFERENCES public.technicians(technician_id);


--
-- Name: work_orders work_orders_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: work_orders work_orders_quotation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_quotation_id_fkey FOREIGN KEY (quotation_id) REFERENCES public.quotations(quotation_id);


--
-- Name: work_orders work_orders_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- Name: workflow_steps workflow_steps_workflow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.workflow_steps
    ADD CONSTRAINT workflow_steps_workflow_id_fkey FOREIGN KEY (workflow_id) REFERENCES public.workflows(workflow_id) ON DELETE CASCADE;


--
-- Name: working_hours working_hours_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: akinadmin
--

ALTER TABLE ONLY public.working_hours
    ADD CONSTRAINT working_hours_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technicians(technician_id);


--
-- PostgreSQL database dump complete
--

\unrestrict psMUOaz2bPktr0EtyrIfEVOZCuWSPs8ai9iLvfy6bFofAS3l4bolDakNuD2oCGi

