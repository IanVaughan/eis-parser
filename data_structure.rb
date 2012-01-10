require 'bindata'

class MainData < BinData::Record
  endian :little

  ## FREQ
  uint32 :freq_max
  uint32 :freq_min
  string :freq_agility_code, :read_length => 1
  int32 :freq_number_of_elements
  int32 :freq_excursion_description
  int32 :freq_drift_rate
  int32 :freq_periodic_description

  string :mop, :read_length => 1

  ## PRI
  double :pri_max
  double :pri_min
  string :pri_agility_code, :read_length => 1
  int32 :pri_number_of_elements
  int32 :pri_excursion_description
  int32 :pri_drift_rate
  uint32 :pri_periodic_description

  ## PW
  string :pw_agility_code, :read_length => 1
  double :pw_max
  double :pw_min
  int32 :pw_number_elements
  int32 :pw_excursion_description

  ## SCAN
  double :scan_period_max
  double :scan_period_min
  string :scan_type, :read_length => 1
  int32 :scan_rate

  double :amplitude
  string :polarisation, :read_length => 1
  uint32 :beamwidth
end

class Threat < BinData::Record
  endian :little

  MainData :library
  MainData :measured

  double :measured_threat_bearing

  uint32 :ecm_threat_priority
  uint32 :technique
  uint32 :range_data_supplied
  uint32 :velocity_data_supplied
  uint32 :altitude_data_supplied
  uint32 :false_target_scale_factor_data_supplied
  uint32 :jog_detection_data_supplied
  uint32 :ecm_threat_range
  uint32 :ecm_threat_velocity
  uint32 :ecm_threat_altitude
  double :ecm_false_target_scale_factor
  uint32 :number_of_consecutive_jogs
  int32 :polarisation_susceptibility_range
  int32 :scan_rate_modulation_susceptibility_range
  int32 :first_jog_threshold
  int32 :second_jog_threshold
end

class EISData < BinData::Record
  endian :little

  uint32 :header1
  uint32 :header2
  #string :length => 8

  Threat :threat1

  #  array :unknown, :type => :uint8, :initial_length => 44
  string :length => 44

  Threat :threat2
  #string :length => (16 * 4) + 4
end
