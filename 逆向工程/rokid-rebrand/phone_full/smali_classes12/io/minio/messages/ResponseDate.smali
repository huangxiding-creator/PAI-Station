.class public Lio/minio/messages/ResponseDate;
.super Ljava/lang/Object;
.source "ResponseDate.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/messages/ResponseDate$ResponseDateConverter;
    }
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
.end annotation

.annotation runtime Lorg/simpleframework/xml/convert/Convert;
    value = Lio/minio/messages/ResponseDate$ResponseDateConverter;
.end annotation


# static fields
.field public static final MINIO_RESPONSE_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;


# instance fields
.field private zonedDateTime:Ljava/time/ZonedDateTime;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 38
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    .line 39
    const-string/jumbo v1, "yyyy-MM-dd\'T\'HH\':\'mm\':\'ss\'Z\'"

    invoke-static {v1, v0}, Ljava/time/format/DateTimeFormatter;->ofPattern(Ljava/lang/String;Ljava/util/Locale;)Ljava/time/format/DateTimeFormatter;

    move-result-object v0

    sget-object v1, Lio/minio/Time;->UTC:Ljava/time/ZoneId;

    invoke-virtual {v0, v1}, Ljava/time/format/DateTimeFormatter;->withZone(Ljava/time/ZoneId;)Ljava/time/format/DateTimeFormatter;

    move-result-object v0

    sput-object v0, Lio/minio/messages/ResponseDate;->MINIO_RESPONSE_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    .line 38
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/time/ZonedDateTime;)V
    .locals 0
    .param p1, "zonedDateTime"    # Ljava/time/ZonedDateTime;

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    iput-object p1, p0, Lio/minio/messages/ResponseDate;->zonedDateTime:Ljava/time/ZonedDateTime;

    .line 47
    return-void
.end method

.method public static fromString(Ljava/lang/String;)Lio/minio/messages/ResponseDate;
    .locals 3
    .param p0, "responseDateString"    # Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonCreator;
    .end annotation

    .line 60
    :try_start_0
    new-instance v0, Lio/minio/messages/ResponseDate;

    sget-object v1, Lio/minio/Time;->RESPONSE_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    invoke-static {p0, v1}, Ljava/time/ZonedDateTime;->parse(Ljava/lang/CharSequence;Ljava/time/format/DateTimeFormatter;)Ljava/time/ZonedDateTime;

    move-result-object v1

    invoke-direct {v0, v1}, Lio/minio/messages/ResponseDate;-><init>(Ljava/time/ZonedDateTime;)V
    :try_end_0
    .catch Ljava/time/format/DateTimeParseException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 61
    :catch_0
    move-exception v0

    .line 62
    .local v0, "e":Ljava/time/format/DateTimeParseException;
    new-instance v1, Lio/minio/messages/ResponseDate;

    sget-object v2, Lio/minio/messages/ResponseDate;->MINIO_RESPONSE_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    invoke-static {p0, v2}, Ljava/time/ZonedDateTime;->parse(Ljava/lang/CharSequence;Ljava/time/format/DateTimeFormatter;)Ljava/time/ZonedDateTime;

    move-result-object v2

    invoke-direct {v1, v2}, Lio/minio/messages/ResponseDate;-><init>(Ljava/time/ZonedDateTime;)V

    return-object v1
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 2

    .line 54
    iget-object v0, p0, Lio/minio/messages/ResponseDate;->zonedDateTime:Ljava/time/ZonedDateTime;

    sget-object v1, Lio/minio/Time;->RESPONSE_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    invoke-virtual {v0, v1}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public zonedDateTime()Ljava/time/ZonedDateTime;
    .locals 1

    .line 50
    iget-object v0, p0, Lio/minio/messages/ResponseDate;->zonedDateTime:Ljava/time/ZonedDateTime;

    return-object v0
.end method
