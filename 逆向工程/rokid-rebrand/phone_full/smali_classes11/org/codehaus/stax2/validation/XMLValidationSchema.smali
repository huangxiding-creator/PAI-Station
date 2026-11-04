.class public interface abstract Lorg/codehaus/stax2/validation/XMLValidationSchema;
.super Ljava/lang/Object;
.source "XMLValidationSchema.java"


# static fields
.field public static final SCHEMA_ID_DTD:Ljava/lang/String; = "http://www.w3.org/XML/1998/namespace"

.field public static final SCHEMA_ID_RELAXNG:Ljava/lang/String; = "http://relaxng.org/ns/structure/0.9"

.field public static final SCHEMA_ID_TREX:Ljava/lang/String; = "http://www.thaiopensource.com/trex"

.field public static final SCHEMA_ID_W3C_SCHEMA:Ljava/lang/String; = "http://www.w3.org/2001/XMLSchema"


# virtual methods
.method public abstract createValidator(Lorg/codehaus/stax2/validation/ValidationContext;)Lorg/codehaus/stax2/validation/XMLValidator;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract getSchemaType()Ljava/lang/String;
.end method
