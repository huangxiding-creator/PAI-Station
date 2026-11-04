.class public Lio/minio/messages/CsvOutputSerialization;
.super Ljava/lang/Object;
.source "CsvOutputSerialization.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "CSV"
.end annotation


# instance fields
.field private fieldDelimiter:Ljava/lang/Character;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "FieldDelimiter"
        required = false
    .end annotation
.end field

.field private quoteCharacter:Ljava/lang/Character;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "QuoteCharacter"
        required = false
    .end annotation
.end field

.field private quoteEscapeCharacter:Ljava/lang/Character;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "QuoteEscapeCharacter"
        required = false
    .end annotation
.end field

.field private quoteFields:Lio/minio/messages/QuoteFields;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "QuoteFields"
        required = false
    .end annotation
.end field

.field private recordDelimiter:Ljava/lang/Character;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "RecordDelimiter"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/Character;Ljava/lang/Character;Ljava/lang/Character;Lio/minio/messages/QuoteFields;Ljava/lang/Character;)V
    .locals 0
    .param p1, "fieldDelimiter"    # Ljava/lang/Character;
    .param p2, "quoteCharacter"    # Ljava/lang/Character;
    .param p3, "quoteEscapeCharacter"    # Ljava/lang/Character;
    .param p4, "quoteFields"    # Lio/minio/messages/QuoteFields;
    .param p5, "recordDelimiter"    # Ljava/lang/Character;

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 51
    iput-object p1, p0, Lio/minio/messages/CsvOutputSerialization;->fieldDelimiter:Ljava/lang/Character;

    .line 52
    iput-object p2, p0, Lio/minio/messages/CsvOutputSerialization;->quoteCharacter:Ljava/lang/Character;

    .line 53
    iput-object p3, p0, Lio/minio/messages/CsvOutputSerialization;->quoteEscapeCharacter:Ljava/lang/Character;

    .line 54
    iput-object p4, p0, Lio/minio/messages/CsvOutputSerialization;->quoteFields:Lio/minio/messages/QuoteFields;

    .line 55
    iput-object p5, p0, Lio/minio/messages/CsvOutputSerialization;->recordDelimiter:Ljava/lang/Character;

    .line 56
    return-void
.end method
