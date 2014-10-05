module ApplicationHelper

  def get_instance_variable_name(instance_variables, var)
    name = nil
    instance_variables.each do |instance_variable|
      name = instance_variable if instance_variable_get(instance_variable) == var
    end
    name.to_s.sub(/^@/, '').split('_').join('-')
  end
end
