#!/usr/bin/env bash
set -e

PROJECT="rylty-app"
REGION="us-central1"
FILTER=""
RUN=false

for arg in "$@"; do
    if [[ "$arg" == "--run" ]]; then
        RUN=true
    else
        FILTER="$arg"
    fi
done

TRIGGERS=(
    dev-AgreementChatRequest
    dev-CheckStatementPeriod
    dev-CopyExternal
    dev-GenerateReport
    dev-GenerateScheduleA
    dev-GenerateSummary
    dev-ImportFromCloud
    dev-ImportFromZip
    dev-organizerUpdate
    dev-pdf-table-extractor
    dev-PdfReconciliation
    dev-RecursiveUnzip
    dev-sortsongtitles
    functions-dev
    functions-prod
    linking-dev
    linking-prod
    prod-AgreementChatRequest
    prod-CheckStatementPeriod
    prod-CopyExternal
    prod-GenerateReport
    prod-GenerateScheduleA
    prod-GenerateSummary
    prod-ImportFromCloud
    prod-ImportFromZip
    prod-OrganizerUpdate
    prod-pdf-table-extractor
    prod-PdfReconciliation
    prod-RecursiveUnzip
    prod-sortsongtitles
)

if [[ "$RUN" == false ]]; then
    echo "DRY RUN — pass --run to execute"
    echo ""
fi

COUNT=0
for trigger in "${TRIGGERS[@]}"; do
    if [[ -z "$FILTER" || "$trigger" == *"$FILTER"* ]]; then
        CMD="gcloud builds triggers run \"$trigger\" --project=\"$PROJECT\" --region=\"$REGION\""
        echo "  $CMD"
        if [[ "$RUN" == true ]]; then
            gcloud builds triggers run "$trigger" --project="$PROJECT" --region="$REGION" &
        fi
        COUNT=$((COUNT + 1))
    fi
done

if [[ $COUNT -eq 0 ]]; then
    echo "No triggers matched filter: '$FILTER'"
    exit 1
fi

if [[ "$RUN" == true ]]; then
    wait
fi

echo ""
echo "$COUNT triggers matched"
