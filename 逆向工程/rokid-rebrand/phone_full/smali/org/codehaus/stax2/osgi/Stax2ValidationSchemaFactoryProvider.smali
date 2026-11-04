.class public interface abstract Lorg/codehaus/stax2/osgi/Stax2ValidationSchemaFactoryProvider;
.super Ljava/lang/Object;
.source "Stax2ValidationSchemaFactoryProvider.java"


# static fields
.field public static final OSGI_SVC_PROP_IMPL_NAME:Ljava/lang/String; = "org.codehaus.stax2.implName"

.field public static final OSGI_SVC_PROP_IMPL_VERSION:Ljava/lang/String; = "org.codehaus.stax2.implVersion"

.field public static final OSGI_SVC_PROP_SCHEMA_TYPE:Ljava/lang/String; = "org.codehaus.stax2.validation.schemaType"


# virtual methods
.method public abstract createValidationSchemaFactory()Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;
.end method

.method public abstract getSchemaType()Ljava/lang/String;
.end method
