-- All medications taken by a patient
SELECT pm.intake_date, m.med_name, pm.status
FROM patient_medications pm
JOIN medications m ON pm.med_id = m.med_id
WHERE pm.patient_id = 1;

-- Patients with skipped medications
SELECT DISTINCT p.patient_id, p.first_name, p.last_name
FROM patient_medications pm
JOIN patients p ON pm.patient_id = p.patient_id
WHERE pm.status = 'skipped';

