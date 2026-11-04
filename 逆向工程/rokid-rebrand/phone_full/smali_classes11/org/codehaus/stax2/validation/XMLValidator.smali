.class public abstract Lorg/codehaus/stax2/validation/XMLValidator;
.super Ljava/lang/Object;
.source "XMLValidator.java"


# static fields
.field public static final CONTENT_ALLOW_ANY_TEXT:I = 0x4

.field public static final CONTENT_ALLOW_NONE:I = 0x0

.field public static final CONTENT_ALLOW_UNDEFINED:I = 0x5

.field public static final CONTENT_ALLOW_VALIDATABLE_TEXT:I = 0x3

.field public static final CONTENT_ALLOW_WS:I = 0x1

.field public static final CONTENT_ALLOW_WS_NONSTRICT:I = 0x2


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 90
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract getAttributeType(I)Ljava/lang/String;
.end method

.method public abstract getIdAttrIndex()I
.end method

.method public abstract getNotationAttrIndex()I
.end method

.method public abstract getSchema()Lorg/codehaus/stax2/validation/XMLValidationSchema;
.end method

.method public getSchemaType()Ljava/lang/String;
    .locals 2

    .line 106
    invoke-virtual {p0}, Lorg/codehaus/stax2/validation/XMLValidator;->getSchema()Lorg/codehaus/stax2/validation/XMLValidationSchema;

    move-result-object v0

    .line 107
    .local v0, "sch":Lorg/codehaus/stax2/validation/XMLValidationSchema;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    invoke-interface {v0}, Lorg/codehaus/stax2/validation/XMLValidationSchema;->getSchemaType()Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1
.end method

.method public abstract validateAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract validateAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[CII)Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract validateElementAndAttributes()I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract validateElementEnd(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract validateElementStart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract validateText(Ljava/lang/String;Z)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract validateText([CIIZ)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract validationCompleted(Z)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method
