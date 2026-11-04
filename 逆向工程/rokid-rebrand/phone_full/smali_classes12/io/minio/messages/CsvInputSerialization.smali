.class public Lio/minio/messages/CsvInputSerialization;
.super Ljava/lang/Object;
.source "CsvInputSerialization.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "CSV"
.end annotation


# instance fields
.field private allowQuotedRecordDelimiter:Z
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "AllowQuotedRecordDelimiter"
        required = false
    .end annotation
.end field

.field private comments:Ljava/lang/Character;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Comments"
        required = false
    .end annotation
.end field

.field private fieldDelimiter:Ljava/lang/Character;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "FieldDelimiter"
        required = false
    .end annotation
.end field

.field private fileHeaderInfo:Lio/minio/messages/FileHeaderInfo;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "FileHeaderInfo"
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

.field private recordDelimiter:Ljava/lang/Character;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "RecordDelimiter"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(ZLjava/lang/Character;Ljava/lang/Character;Lio/minio/messages/FileHeaderInfo;Ljava/lang/Character;Ljava/lang/Character;Ljava/lang/Character;)V
    .locals 0
    .param p1, "allowQuotedRecordDelimiter"    # Z
    .param p2, "comments"    # Ljava/lang/Character;
    .param p3, "fieldDelimiter"    # Ljava/lang/Character;
    .param p4, "fileHeaderInfo"    # Lio/minio/messages/FileHeaderInfo;
    .param p5, "quoteCharacter"    # Ljava/lang/Character;
    .param p6, "quoteEscapeCharacter"    # Ljava/lang/Character;
    .param p7, "recordDelimiter"    # Ljava/lang/Character;

    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    iput-boolean p1, p0, Lio/minio/messages/CsvInputSerialization;->allowQuotedRecordDelimiter:Z

    .line 60
    iput-object p2, p0, Lio/minio/messages/CsvInputSerialization;->comments:Ljava/lang/Character;

    .line 61
    iput-object p3, p0, Lio/minio/messages/CsvInputSerialization;->fieldDelimiter:Ljava/lang/Character;

    .line 62
    iput-object p4, p0, Lio/minio/messages/CsvInputSerialization;->fileHeaderInfo:Lio/minio/messages/FileHeaderInfo;

    .line 63
    iput-object p5, p0, Lio/minio/messages/CsvInputSerialization;->quoteCharacter:Ljava/lang/Character;

    .line 64
    iput-object p6, p0, Lio/minio/messages/CsvInputSerialization;->quoteEscapeCharacter:Ljava/lang/Character;

    .line 65
    iput-object p7, p0, Lio/minio/messages/CsvInputSerialization;->recordDelimiter:Ljava/lang/Character;

    .line 66
    return-void
.end method
