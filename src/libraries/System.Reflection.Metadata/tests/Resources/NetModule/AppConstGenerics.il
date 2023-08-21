.assembly _ { }

.class public sequential ansi sealed beforefieldinit Test
       extends [System.Runtime]System.ValueType
{
    .pack 0
    .size 1

    .method public hidebysig newslot virtual 
        instance void Foo<T, literal !!T U>() cil managed noinlining
    {
        ldarg.0
        ldtoken !!U
        call instance void valuetype Test::Print<!!T>(!!0)

        ret
    }

    .method public hidebysig newslot virtual 
        instance void Print<T>(!!T) cil managed noinlining
    {
        ldarg.1
        box !!T
        call void [System.Console]System.Console::WriteLine(object)

        ret
    }
}


.class public auto ansi beforefieldinit Test`2<T, literal !T V>
       extends [System.Runtime]System.Object
{
  .method public hidebysig specialname rtspecialname 
        instance void .ctor () cil managed 
    {
        .maxstack 8

        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }

  .method public hidebysig newslot virtual 
        instance void M<U, literal !!U W>() cil managed
    {
        .maxstack 8

        ldtoken !V
        box !T
        call void [System.Console]System.Console::WriteLine(object)

        ldtoken !!W
        box !!U
        call void [System.Console]System.Console::WriteLine(object)

        ret
    }
}
