.class public interface abstract Lorg/codehaus/stax2/validation/Validatable;
.super Ljava/lang/Object;
.source "Validatable.java"


# virtual methods
.method public abstract setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;
.end method

.method public abstract stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidator;)Lorg/codehaus/stax2/validation/XMLValidator;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract validateAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method
