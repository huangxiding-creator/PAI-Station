.class public Lio/minio/Time;
.super Ljava/lang/Object;
.source "Time.java"


# static fields
.field public static final AMZ_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

.field public static final EXPIRATION_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

.field public static final HTTP_HEADER_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

.field public static final RESPONSE_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

.field public static final SIGNER_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

.field public static final UTC:Ljava/time/ZoneId;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 26
    const-string v0, "Z"

    invoke-static {v0}, Ljava/time/ZoneId;->of(Ljava/lang/String;)Ljava/time/ZoneId;

    move-result-object v0

    sput-object v0, Lio/minio/Time;->UTC:Ljava/time/ZoneId;

    .line 28
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    .line 29
    const-string/jumbo v1, "yyyyMMdd\'T\'HHmmss\'Z\'"

    invoke-static {v1, v0}, Ljava/time/format/DateTimeFormatter;->ofPattern(Ljava/lang/String;Ljava/util/Locale;)Ljava/time/format/DateTimeFormatter;

    move-result-object v0

    sget-object v1, Lio/minio/Time;->UTC:Ljava/time/ZoneId;

    invoke-virtual {v0, v1}, Ljava/time/format/DateTimeFormatter;->withZone(Ljava/time/ZoneId;)Ljava/time/format/DateTimeFormatter;

    move-result-object v0

    sput-object v0, Lio/minio/Time;->AMZ_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    .line 31
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    .line 32
    const-string/jumbo v1, "yyyy-MM-dd\'T\'HH\':\'mm\':\'ss\'.\'SSS\'Z\'"

    invoke-static {v1, v0}, Ljava/time/format/DateTimeFormatter;->ofPattern(Ljava/lang/String;Ljava/util/Locale;)Ljava/time/format/DateTimeFormatter;

    move-result-object v0

    sget-object v1, Lio/minio/Time;->UTC:Ljava/time/ZoneId;

    invoke-virtual {v0, v1}, Ljava/time/format/DateTimeFormatter;->withZone(Ljava/time/ZoneId;)Ljava/time/format/DateTimeFormatter;

    move-result-object v0

    sput-object v0, Lio/minio/Time;->RESPONSE_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    .line 37
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    .line 38
    const-string/jumbo v1, "yyyyMMdd"

    invoke-static {v1, v0}, Ljava/time/format/DateTimeFormatter;->ofPattern(Ljava/lang/String;Ljava/util/Locale;)Ljava/time/format/DateTimeFormatter;

    move-result-object v0

    sget-object v1, Lio/minio/Time;->UTC:Ljava/time/ZoneId;

    invoke-virtual {v0, v1}, Ljava/time/format/DateTimeFormatter;->withZone(Ljava/time/ZoneId;)Ljava/time/format/DateTimeFormatter;

    move-result-object v0

    sput-object v0, Lio/minio/Time;->SIGNER_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    .line 40
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    .line 41
    const-string v1, "EEE\',\' dd MMM yyyy HH\':\'mm\':\'ss \'GMT\'"

    invoke-static {v1, v0}, Ljava/time/format/DateTimeFormatter;->ofPattern(Ljava/lang/String;Ljava/util/Locale;)Ljava/time/format/DateTimeFormatter;

    move-result-object v0

    sget-object v1, Lio/minio/Time;->UTC:Ljava/time/ZoneId;

    invoke-virtual {v0, v1}, Ljava/time/format/DateTimeFormatter;->withZone(Ljava/time/ZoneId;)Ljava/time/format/DateTimeFormatter;

    move-result-object v0

    sput-object v0, Lio/minio/Time;->HTTP_HEADER_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    .line 43
    sget-object v0, Lio/minio/Time;->RESPONSE_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    sput-object v0, Lio/minio/Time;->EXPIRATION_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
