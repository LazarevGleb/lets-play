package com.dag.lets_play.validation

import jakarta.validation.Constraint
import jakarta.validation.constraints.NotNull
import jakarta.validation.constraints.Pattern
import kotlin.reflect.KClass

@NotNull
@Pattern(regexp = "^\\+7\\d{10}")
@Target(
    AnnotationTarget.FUNCTION,
    AnnotationTarget.PROPERTY_GETTER,
    AnnotationTarget.PROPERTY_SETTER,
    AnnotationTarget.FIELD,
    AnnotationTarget.ANNOTATION_CLASS,
    AnnotationTarget.CONSTRUCTOR,
    AnnotationTarget.VALUE_PARAMETER,
)
@Retention(AnnotationRetention.RUNTIME)
@Constraint(validatedBy = [])
@MustBeDocumented
annotation class ValidPhone(
    val message: String = "Номер телефона должен быть в формате +71112223344",
    val groups: Array<KClass<*>> = [],
    val payload: Array<KClass<out Any>> = []
)
