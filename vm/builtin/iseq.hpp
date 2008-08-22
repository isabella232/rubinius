#ifndef RBX_BUILTIN_ISEQ_HPP
#define RBX_BUILTIN_ISEQ_HPP

#include "builtin/object.hpp"
#include "type_info.hpp"

namespace rubinius {
  class Tuple;

  class InstructionSequence : public Object {
  public:
    const static size_t fields = 2;
    const static object_type type = ISeqType;

    Tuple* opcodes; // slot
    FIXNUM stack_depth; // slot

    static InstructionSequence* create(STATE, size_t instructions);

    static size_t instruction_width(size_t op);

    void post_marshal(STATE);

    class Info : public TypeInfo {
    public:
      BASIC_TYPEINFO(TypeInfo)
    };

#include "gen/iseq_instruction_names.hpp"
  };

}

#endif