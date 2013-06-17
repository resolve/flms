# Returns a replica of the given hash.
# Don't use this method for real objects with superclasses, prototypes, and stuff.
modularity.clone_hash = (obj) ->
  result = {}
  result[key] = value for own key, value of obj
  result


# Returns an object that contains only the attributes
# that are different between obj_1 and obj_2.
# Only looks for changed attributes, not missing attributes.
modularity.object_diff = (obj_1, obj_2) ->
  result = {}
  for own key, value_2 of obj_2
    do (key, value_2) ->
      value_1 = obj_1[key]
      result[key] = value_2 if value_1 != value_2
  result


# Returns the number of attributes of the given object.
# NOTE(KG): This doesn't work in IE8.
modularity.object_length = (obj) ->
  Object.keys(obj).length


# Allows to populate the given object through a callback.
modularity.tap = (obj, callback) ->
  callback obj
  obj

